## **Arabic Chat Support**

This plugin provides full Arabic language support in AMX Mod X servers.  
It fixes issues where Arabic characters appear reversed or broken, making the chat more readable for Arabic-speaking players.


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
<span style="color:blue">
`; Chat / Messages ` \
**`arabic_supporter.amxx `\**
`adminchat.amxx		; console chat commands ` \
`antiflood.amxx		; prevent clients from chat-flooding the server ` 
</span>

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
