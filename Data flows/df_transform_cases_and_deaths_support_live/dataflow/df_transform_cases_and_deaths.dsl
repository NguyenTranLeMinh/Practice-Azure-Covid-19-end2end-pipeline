source(output(
		country as string,
		country_code as string,
		continent as string,
		population as integer,
		indicator as string,
		daily_count as integer,
		date as date,
		rate_14_day as double,
		source as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> CasesAndDeathsSource
source(output(
		country as string,
		country_code_2_digit as string,
		country_code_3_digit as string,
		continent as string,
		population as integer
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> CountryLookup
CasesAndDeathsSource filter(continent == "Europe" && not(isNull(country_code))) ~> Filter
select1 pivot(groupBy(country,
		country_code,
		population,
		{reported date},
		source),
	pivotBy(indicator, ['confirmed cases', 'deaths']),
	count = sum(daily_count),
	columnNaming: '$V_$N',
	lateral: true) ~> pivotIndicator
Filter select(mapColumn(
		country,
		country_code,
		population,
		indicator,
		daily_count,
		{reported date} = date,
		source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> select1
pivotIndicator, CountryLookup lookup(pivotIndicator@country == CountryLookup@country,
	multiple: false,
	pickup: 'any',
	broadcast: 'auto')~> lookupCounttryCode
lookupCounttryCode select(mapColumn(
		country = pivotIndicator@country,
		country_code_2_digit,
		country_code_3_digit,
		population = pivotIndicator@population,
		cases_count = {confirmed cases_count},
		deaths_count,
		{reported date},
		source
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectRemoveDuplicate
selectRemoveDuplicate sink(allowSchemaDrift: true,
	validateSchema: false,
	truncate: true,
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> casesAndDeathsSink