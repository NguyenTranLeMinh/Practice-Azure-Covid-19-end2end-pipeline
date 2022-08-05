# Practice-Azure-Covid-19-end2end-pipeline

1. Overview diagram of this project:
![Overview diagram](https://raw.githubusercontent.com/NguyenTranLeMinh/Practice-Azure-Covid-19-end2end-pipeline/master/Diagrams/1.Overview%20Diagram.png)

2. Di chuyển dữ liệu từ link http vào Azure data lake gen2 gồm các thành phần sau:
- Tạo 2 link services, một cái ứng với http connector, một cái ứng với data lake.
- Tạo 2 datasets để định nghĩa schema và các thông tin cần thiết cho dữ liệu chứa bên trong.
- Thao tác COPY trong khi tạo pipeline từ dataset này tới dataset kia.

Từ azure blob tới data lake gen2 tương tự, thay http connector bằng blob connector.
![http to data lake gen2](https://raw.githubusercontent.com/NguyenTranLeMinh/Practice-Azure-Covid-19-end2end-pipeline/master/Diagrams/2.Http%20to%20Data%20lake%20Gen2.png)

3. Biến đổi các tệp trong data lake:
- Các tệp sau khi nạp vào data lake gồm cdc và population:
  + CDC gồm: cases_deaths là cố ca nhiễm và mất ngày/tuần, hospital_admissions là số ca chiếm chỗ hồi sức đặc biệt/chỗ thông thường trong bệnh viện, testing liên quan đến số lần test covid,...
  + Population là thông tin bổ sung về dân số theo độ tuổi.
- Ngoài ra còn có các tệp dim_country, dim_date dùng cho mục đích lookup, bổ sung thêm các cột cần thiết nhanh chóng hơn, như country_code, week_of_year,...
- Dữ liệu được biến đổi bằng cách tạo Data pipeline bên trong chứa Data flow tương ứng trong Azure Data factory.
  + Vd data flow cho biến đổi cases_deaths, được ghi vào lại data lake (raw data là trong raw container, còn data được xử l1y đặt trong processed container:
  ![df_cases_deaths](https://raw.githubusercontent.com/NguyenTranLeMinh/Practice-Azure-Covid-19-end2end-pipeline/master/Data%20flows/df_transform_cases_and_deaths_support_live/df_image.PNG)
  + Vd data flow cho biến đổi hospital_admissions, được ghi vào lại data lake:
  ![df_hospital_admissions](https://raw.githubusercontent.com/NguyenTranLeMinh/Practice-Azure-Covid-19-end2end-pipeline/master/Data%20flows/df_transform_hospital_admissions_support_live/df_image.PNG)
