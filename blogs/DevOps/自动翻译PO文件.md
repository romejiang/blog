
```shell

# 1.提出csv文件
npx po-csv file.po > untranslated.csv

# 2.上传谷歌文档，自动翻译
# Upload untranslated_XX.csv to Google Sheet
# Use the formula
=GOOGLETRANSLATE(h2;"en";"zh")
# 在左上角输入， h3:h3000 , 选中最有的框，然后 ctrl+D ，填充所有
# Convert the translated columns to text using Copy the column then paste values only

# 3。下载
# Export file to CSV translated_XX.csv (download CSV)
# Convert the CSV file to PO file using the following command

# 4. 合并
npx po-csv file.po translated.csv > translated.po
mv translated.po file.po
```


https://github.com/marek-saji/po-csv
https://github.com/naskio/po-auto-translation