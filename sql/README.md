# สคริปต์ MySQL

`schema.sql` เป็นคำสั่งสร้างตาราง 17 ตารางที่เขียนจาก Data Dictionary ในรายงานหน้า 27–30 ไม่ใช่โค้ดต้นฉบับที่มีอยู่ใน PDF โดยคงชื่อตาราง ชื่อคอลัมน์ ชนิดข้อมูล และ Nullable = N ตามตารางข้อมูลต้นฉบับ ไม่เพิ่มข้อมูลตัวอย่าง

## วิธีใช้งาน

ใช้ MySQL พร้อมฐานข้อมูลว่างที่สร้างไว้แล้ว เปิด MySQL client แล้วเลือกฐานข้อมูลของคุณ:

```sql
USE `ชื่อฐานข้อมูลของคุณ`;
SOURCE sql/schema.sql;
SHOW TABLES;
```

รัน client จากโฟลเดอร์รากของโปรเจกต์ เพื่อให้เส้นทาง `sql/schema.sql` ถูกต้อง หรือใช้ MySQL Workbench เปิดไฟล์ `schema.sql` เลือก default schema ที่เป็นฐานข้อมูลว่าง แล้วรันสคริปต์

สคริปต์ไม่มีคำสั่งลบตาราง รันครั้งเดียวในฐานข้อมูลว่าง หากตารางมีอยู่แล้ว MySQL จะแจ้งข้อผิดพลาด ชื่อที่มีช่องว่างหรือเป็นคำสงวนต้องครอบด้วย backticks เช่น `ORDER`, `ORDER LINE` และ `STARBUCK CARD`

## จุดที่ต้องอ้างอิงต้นฉบับ

- ใช้ Data Dictionary หน้า 27–30 เป็นหลักเมื่อชื่อหรือคอลัมน์ต่างจากภาพ Relational Schema เช่น `ORDER.ordID`, `MEMBER.point`, `STARBUCK CARD.totalMoneyleft` และ `RECEIPT.total_amount` โดยไม่แก้รายงานหรือภาพต้นฉบับ
- `BAKERY.productID` ระบุเฉพาะ FK ใน Data Dictionary จึงคง FK และไม่เพิ่ม PK ให้เอง
- `MEMBER_PHONE.memberPhone` ระบุ PK,FK อ้างอิง `MEMBER` แต่ `MEMBER` ไม่มีคอลัมน์เบอร์โทรศัพท์ และ `memberID` เป็น INT ซึ่งต่างจาก `memberPhone` ที่เป็น VARCHAR(10) จึงคง composite PK (`memberID`, `memberPhone`) และสร้างเฉพาะ FK `memberID` ไปยัง `MEMBER.memberID` ส่วน FK ของ `memberPhone` ยังไม่สร้าง เนื่องจากไม่มีคอลัมน์ปลายทางที่สอดคล้องในรายงาน
- ไม่เพิ่ม AUTO_INCREMENT, DEFAULT, UNIQUE, CHECK หรือกฎ CASCADE ที่รายงานไม่ได้ระบุ
- ไม่มีข้อมูลตัวอย่างหรือคำสั่ง INSERT ใน PDF จึงไม่สร้างข้อมูลเพิ่ม ไฟล์อ้างอิงเดิมใน `database/` ยังคงเดิม

## การตรวจสอบ

ตรวจโครงสร้างสคริปต์และความสอดคล้องของคีย์กับ Data Dictionary แล้ว ยังไม่ได้ทดสอบรันบน MySQL server ในสภาพแวดล้อมนี้
