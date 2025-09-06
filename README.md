## **Arabic Chat Support**

This plugin provides full Arabic language support in AMX Mod X servers.  
It fixes issues where Arabic characters appear reversed or broken, making the chat more readable for Arabic-speaking players.

## Requirements
- amxmodx 1.9 or up [amxmodx dev](https://www.amxmodx.org/downloads-new.php)
- [amxmodx 1.9 or up from amxxdrop](https://www.amxmodx.org/amxxdrop/)
**Features:**
```
- Proper display of Arabic text in chat  
- Automatic correction of reversed words  
- Compatible with most AMX Mod X versions  
- Lightweight and easy to use
```

**Installation:**
1. Download the plugin (.amxx) file  
2. Place it in your *plugins* folder  
3. Add it to *plugins.ini*  
4. Restart your server  


**Example:** add this line to **plugins.ini** before **adminchat.amxx** 

`; Chat / Messages ` \
**`arabic_supporter.amxx `**\
`adminchat.amxx		; console chat commands ` \
`antiflood.amxx		; prevent clients from chat-flooding the server ` 


## Screenshots:
### Preview
<img src="https://i.ibb.co/B52dvy6n/gfgf.png" alt="Sample Image" width="700" align="center">
<img src="https://i.ibb.co/mrH9DF1G/jjjjj.png" alt="Sample Image" width="700" align="center">
<img src="https://i.ibb.co/pvDgB90w/kkkk.png" alt="Sample Image" width="700" align="center">


> **Note:** This plugin only adjusts text display. It does not affect gameplay or server performance.

### If you find this useful, feel free to share feedback or report any issues.

## api pawn amxx (optional)
```pawn
#include <arabic_support_x>
...
new text[]="اهلا بك"
if(is_arabic_text(text)){
    client_print(0,print_chat,"is arab")
}
else{
    client_print(0,print_chat,"is not arab")
}
....
new text[]="اهلا بك"
arabic_fix_text(text)
client_print(0,print_chat,"%s",text)
```

## **دعم الدردشة العربية**

هذا الملحق (Plugin) يوفر دعمًا كاملاً للغة العربية في خوادم **AMX Mod X**.  
يقوم بإصلاح مشكلة ظهور الأحرف العربية بشكل مقلوب أو غير مفهوم، مما يجعل الدردشة أوضح وأسهل للقراءة بالنسبة للاعبين الناطقين بالعربية.  

**الميزات:**
- عرض صحيح للنصوص العربية في الدردشة  
- تصحيح تلقائي للكلمات المعكوسة  
- متوافق مع معظم إصدارات AMX Mod X  
- خفيف وسهل الاستخدام  

**مثال:** أضف السطر التالي في **plugins.ini** قبل **adminchat.amxx**  
`; Chat / Messages ` \
**`arabic_supporter.amxx `**\
`adminchat.amxx		; console chat commands ` \
`antiflood.amxx		; prevent clients from chat-flooding the server ` 

**طريقة التثبيت:**
1. قم بتحميل ملف الملحق (.amxx)  
2. ضع الملف داخل مجلد *plugins*  
3. أضف اسمه داخل ملف *plugins.ini*  
4. أعد تشغيل الخادم (server)  

## صور توضيحية:
### معاينة
<img src="https://i.ibb.co/B52dvy6n/gfgf.png" alt="صورة تجريبية" width="700" align="center">
<img src="https://i.ibb.co/mrH9DF1G/jjjjj.png" alt="صورة تجريبية" width="700" align="center">
<img src="https://i.ibb.co/pvDgB90w/kkkk.png" alt="صورة تجريبية" width="700" align="center">

> **ملاحظة:** هذا الملحق يقوم فقط بضبط طريقة عرض النصوص، ولا يؤثر على أسلوب اللعب أو أداء الخادم.

### إذا وجدت الملحق مفيدًا، لا تتردد في مشاركة رأيك أو التبليغ عن أي مشاكل.

## مثال API بلغة Pawn (اختياري)
```pawn
#include <arabic_support_x>
...
new text[]="اهلا بك"
if(is_arabic_text(text)){
    client_print(0,print_chat,"نص عربي")
}
else{
    client_print(0,print_chat,"ليس نص عربي")
}
....
new text[]="اهلا بك"
arabic_fix_text(text)
client_print(0,print_chat,"%s",text)
```

