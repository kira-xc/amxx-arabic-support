#include <amxmodx>
#include <regex>

#define PATTERN "(ض|ص|ث|ق|ف|غ|ع|ه|خ|ح|ج|د|ش|س|ي|ب|ل|ا|ت|ن|م|ك|ط|ئ|ء|ؤ|ر|ى|ة|و|ز|ظ|ذ|أ|؟)+"


#define MAX_CLR_Edit 10

new g_Colors[MAX_CLR_Edit][] = {"COL_WHITE", "COL_RED", "COL_GREEN", "COL_BLUE", "COL_YELLOW", "COL_MAGENTA", "COL_CYAN", "COL_ORANGE", "COL_OCEAN", "COL_MAROON"}

new g_says[33][192],g_teamsays[33][192],g_amx_says[33][192]
new g_amx_chat[33][192],g_amx_csays[33][192],g_amx_tsays[33][192]

public plugin_init()
{
    register_plugin("Arabic Supporter", "1.0beta", "Raheem & CT Spawn")
    register_dictionary("adminchat.txt")
    register_clcmd("say", "cmdSayChat") 
    register_clcmd("say_team", "cmdSayAdmin")
    register_concmd("amx_say", "cmdSay")
    register_concmd("amx_chat", "cmdChat")
    register_concmd("amx_tsay", "cmdTsay")
    register_concmd("amx_csay", "cmdCsay")
     
}


public _is_arabic_text(plugin, params) {
    new text[192]
    get_string(1,text,191)
    return arabic_checker(text);
}

public _arabic_fix_text(plugin, params) {
    new text[192]
    get_string(1,text,191)
    arabic_replacement(text)
    set_string(1,text,191)
}

public arabic_replacement(said[]){
    new said_to_utf16[192], said_to_utf8[576]

    replacer_ar(said)
    MultiByteToWideChar(said, said_to_utf16)

    ReverseString(said_to_utf16)
    finishing_para(said_to_utf16)

    WideCharToMultiByte(said_to_utf16, said_to_utf8)

    copy(said,191,said_to_utf8)
}


stock arabic_checker(const szString[])
{
    new Regex:result;
    result = regex_match(szString, PATTERN);
    if(result!=REGEX_MATCH_FAIL && result!=REGEX_PATTERN_FAIL && result!=REGEX_NO_MATCH){
        regex_free(result)
        return true;
    }
    return false;
}

public plugin_natives() {
	register_library("arabic_support_x");
	register_native("is_arabic_text", "_is_arabic_text");
	register_native("arabic_fix_text", "_arabic_fix_text");
}

public cmdSayChat(id)
{	
    new said[6], i = 0
    read_argv(1, said, charsmax(said))

    while (said[i] == '@')
    {
        i++
    }

    if (!i || i > 3)
    {
        new message[192]
        read_args(message, charsmax(message))
        remove_quotes(message)
        if(equali(g_says[id],message)){
            copy(g_says[id],191,"")
            return PLUGIN_CONTINUE
        }
        if(arabic_checker(message)){
            arabic_replacement(message)
            copy(g_says[id],191,message)
            client_cmd(id,"say ^"%s^"",message)
            return PLUGIN_HANDLED
        }
        return PLUGIN_CONTINUE
    }

    new message[192],charr=0;
    read_args(message, charsmax(message))
    remove_quotes(message)
    if(equali(g_says[id],message)){
        copy(g_says[id],191,"")
        return PLUGIN_CONTINUE
    }
    if(i+1>=strlen(message)){
        return PLUGIN_CONTINUE
    }
    new a = 0

    switch (said[i])
    {
        case 'r': a = 1
        case 'g': a = 2
        case 'b': a = 3
        case 'y': a = 4
        case 'm': a = 5
        case 'c': a = 6
        case 'o': a = 7
    }


    if (a)
    {
        charr=message[i]
        copy(message,191,message[i+1])
    }
    else{
        copy(message,191,message[i])
    }
    if(arabic_checker(message)){
        arabic_replacement(message)
        new attt[6]
        for(new j=0;j<i;j++){
           attt[j]='@'
        }
        if (a){
            //formatex(attt[i],5-i,"%s%c",attt,charr)
            attt[i]=charr
        }
        formatex(g_says[id],191,"%s%s",attt,message)
        client_cmd(id,"say ^"%s%s^"",attt,message)
        return PLUGIN_HANDLED
    }
    return PLUGIN_CONTINUE
}


public cmdSayAdmin(id)
{
    new said[2]
    read_argv(1, said, charsmax(said))

    if (said[0] != '@'){
        new message[192]
        read_args(message, charsmax(message))
        remove_quotes(message)
        if(equali(g_teamsays[id],message)){
            copy(g_teamsays[id],191,"")
            return PLUGIN_CONTINUE
        }
        if(arabic_checker(message)){
            arabic_replacement(message)
            copy(g_teamsays[id],191,message)
            client_cmd(id,"say_team ^"%s^"",message)
            return PLUGIN_HANDLED
        }
        return PLUGIN_CONTINUE
    }
    new message[192]
    read_args(message, charsmax(message))
    remove_quotes(message)
    if(equali(g_teamsays[id],message)){
        copy(g_teamsays[id],191,"")
        return PLUGIN_CONTINUE
    }
    copy(message,191,message[1])
    if(arabic_checker(message)){
        arabic_replacement(message)
        formatex(g_teamsays[id],191,"@%s",message)
        client_cmd(id,"say_team ^"@%s^"",message)
        return PLUGIN_HANDLED
    }
    return PLUGIN_CONTINUE

}


public cmdSay(id)
{
    new message[192]
    read_args(message, charsmax(message))
    remove_quotes(message)
    if(equali(g_amx_says[id],message)){
        copy(g_amx_says[id],191,"")
        return PLUGIN_CONTINUE
    }
    if(arabic_checker(message)){
        arabic_replacement(message)
        copy(g_amx_says[id],191,message)
        client_cmd(id,"amx_say ^"%s^"",message)
        return PLUGIN_HANDLED
    }

    return PLUGIN_CONTINUE
}

public cmdChat(id)
{
    new message[192]
    read_args(message, charsmax(message))
    remove_quotes(message)
    if(equali(g_amx_chat[id],message)){
        copy(g_amx_chat[id],191,"")
        return PLUGIN_CONTINUE
    }
    if(arabic_checker(message)){
        arabic_replacement(message)
        copy(g_amx_chat[id],191,message)
        client_cmd(id,"amx_chat ^"%s^"",message)
        return PLUGIN_HANDLED
    }
    return PLUGIN_CONTINUE
}


public cmdTsay(id)
{
    new color[16] , color2[16], message[192];

    read_args(message, charsmax(message))
    remove_quotes(message)
    parse(message, color, charsmax(color))

    new found = 0;
    new lang[3], langnum = get_langsnum()

    for (new i = 0; i < MAX_CLR_Edit; ++i)
    {
        for (new j = 0; j < langnum; j++)
        {
            get_lang(j, lang)
            formatex(color2, charsmax(color2), "%L", lang, g_Colors[i])
            
            if (equali(color, color2))
            {
                found = 1
                break
            }
        }
        if (found == 1)
            break
    }

    if(equali(g_amx_tsays[id],message)){
        copy(g_amx_tsays[id],191,"")
        return PLUGIN_CONTINUE
    }
    new length = found ? (strlen(color) + 1) : 0
    copy(message,191,message[length])
    if(arabic_checker(message)){
        arabic_replacement(message)
        formatex(g_amx_tsays[id],191,"%s ^"%s^"",color,message)
        client_cmd(id,"amx_tsay %s ^"%s^"",color,message)
        return PLUGIN_HANDLED
    } 

    return PLUGIN_CONTINUE
}



public cmdCsay(id)
{
    new color[16], color2[16], message[192];


    read_args(message, charsmax(message))
    remove_quotes(message)
    parse(message, color, charsmax(color))

    new found = 0;
    new lang[3], langnum = get_langsnum()

    for (new i = 0; i < MAX_CLR_Edit; ++i)
    {
        for (new j = 0; j < langnum; j++)
        {
            get_lang(j, lang)
            formatex(color2, charsmax(color2), "%L", lang, g_Colors[i])
            
            if (equali(color, color2))
            {
                found = 1
                break
            }
        }
        if (found == 1)
            break
    }

    new length = found ? (strlen(color) + 1) : 0

    if(equali(g_amx_csays[id],message)){
        copy(g_amx_csays[id],191,"")
        return PLUGIN_CONTINUE
    }
    copy(message,191,message[length])
    if(arabic_checker(message)){
        arabic_replacement(message)
        formatex(g_amx_csays[id],191,"%s ^"%s^"",color,message)
        client_cmd(id,"amx_csay %s ^"%s^"",color,message)
        return PLUGIN_HANDLED
    } 

    return PLUGIN_CONTINUE
}


stock has_Arabic(chr[])
{
    if(equali(chr,"؟",2)) return true
    else if(equali(chr,"ح",2)) return true
    else if(equali(chr,"خ",2)) return true
    else if(equali(chr,"ه",2)) return true
    else if(equali(chr,"ع",2)) return true
    else if(equali(chr,"غ",2)) return true
    else if(equali(chr,"ف",2)) return true
    else if(equali(chr,"ق",2)) return true
    else if(equali(chr,"ث",2)) return true
    else if(equali(chr,"ص",2)) return true
    else if(equali(chr,"ض",2)) return true
    else if(equali(chr,"أ",2)) return true
    else if(equali(chr,"ذ",2)) return true
    else if(equali(chr,"ظ",2)) return true
    else if(equali(chr,"ز",2)) return true
    else if(equali(chr,"و",2)) return true
    else if(equali(chr,"ة",2)) return true
    else if(equali(chr,"ى",2)) return true
    else if(equali(chr,"ر",2)) return true
    else if(equali(chr,"ؤ",2)) return true
    else if(equali(chr,"ء",2)) return true
    else if(equali(chr,"ئ",2)) return true
    else if(equali(chr,"ط",2)) return true
    else if(equali(chr,"ك",2)) return true
    else if(equali(chr,"م",2)) return true
    else if(equali(chr,"ن",2)) return true
    else if(equali(chr,"ت",2)) return true
    else if(equali(chr,"ا",2)) return true
    else if(equali(chr,"ل",2)) return true
    else if(equali(chr,"ب",2)) return true
    else if(equali(chr,"ي",2)) return true
    else if(equali(chr,"س",2)) return true
    else if(equali(chr,"ش",2)) return true
    else if(equali(chr,"د",2)) return true
    else if(equali(chr,"ج",2)) return true
    else return false
}



stock first_replace(said[],pos) 
{
    new indexo=-1;
    if(equali(said[pos],"ب",2)) indexo=replace_stringex(said[pos], 191-pos, "ب", "ﺑ")
    else if(equali(said[pos],"ت",2)) indexo=replace_stringex(said[pos], 191-pos, "ت", "ﺗ")
    else if(equali(said[pos],"ث",2)) indexo=replace_stringex(said[pos], 191-pos, "ث", "ﺛ")
    else if(equali(said[pos],"ج",2)) indexo=replace_stringex(said[pos], 191-pos, "ج", "ﺟ")
    else if(equali(said[pos],"ح",2)) indexo=replace_stringex(said[pos], 191-pos, "ح", "ﺣ")
    else if(equali(said[pos],"خ",2)) indexo=replace_stringex(said[pos], 191-pos, "خ", "ﺧ")
    else if(equali(said[pos],"س",2)) indexo=replace_stringex(said[pos], 191-pos, "س", "ﺳ")
    else if(equali(said[pos],"ش",2)) indexo=replace_stringex(said[pos], 191-pos, "ش", "ﺷ")
    else if(equali(said[pos],"ص",2)) indexo=replace_stringex(said[pos], 191-pos, "ص", "ﺻ")
    else if(equali(said[pos],"ض",2)) indexo=replace_stringex(said[pos], 191-pos, "ض", "ﺿ")
    else if(equali(said[pos],"ع",2)) indexo=replace_stringex(said[pos], 191-pos, "ع", "ﻋ")
    else if(equali(said[pos],"غ",2)) indexo=replace_stringex(said[pos], 191-pos, "غ", "ﻏ")
    else if(equali(said[pos],"ف",2)) indexo=replace_stringex(said[pos], 191-pos, "ف", "ﻓ")
    else if(equali(said[pos],"ق",2)) indexo=replace_stringex(said[pos], 191-pos, "ق", "ﻗ")
    else if(equali(said[pos],"ك",2)) indexo=replace_stringex(said[pos], 191-pos, "ك", "ﻛ")
    else if(equali(said[pos],"م",2)) indexo=replace_stringex(said[pos], 191-pos, "م", "ﻣ")
    else if(equali(said[pos],"ن",2)) indexo=replace_stringex(said[pos], 191-pos, "ن", "ﻧ")
    else if(equali(said[pos],"ي",2)) indexo=replace_stringex(said[pos], 191-pos, "ي", "ﻳ")
    else if(equali(said[pos],"ه",2)) indexo=replace_stringex(said[pos], 191-pos, "ه", "ﻫ")
    else if(equali(said[pos],"ل",2)) indexo=replace_stringex(said[pos], 191-pos, "ل", "ﻟ")
    else if(equali(said[pos],"ئ",2)) indexo=replace_stringex(said[pos], 191-pos, "ئ", "ﺋ")
    if(indexo!=-1) return true
    else return false
}


stock middle_replace(said[],pos) 
{ 
    new indexo=-1;
    if(equali(said[pos],"أ",2)) indexo=replace_stringex(said[pos], 191-pos, "أ", "ﺄ")
    else if(equali(said[pos],"ا",2)) indexo=replace_stringex(said[pos], 191-pos, "ا", "ﺎ")
    else if(equali(said[pos],"ب",2)) indexo=replace_stringex(said[pos], 191-pos, "ب", "ﺑ")
    else if(equali(said[pos],"ت",2)) indexo=replace_stringex(said[pos], 191-pos, "ت", "ﺗ")
    else if(equali(said[pos],"ث",2)) indexo=replace_stringex(said[pos], 191-pos, "ث", "ﺛ")
    else if(equali(said[pos],"ج",2)) indexo=replace_stringex(said[pos], 191-pos, "ج", "ﺟ")
    else if(equali(said[pos],"ح",2)) indexo=replace_stringex(said[pos], 191-pos, "ح", "ﺣ")
    else if(equali(said[pos],"خ",2)) indexo=replace_stringex(said[pos], 191-pos, "خ", "ﺧ")
    else if(equali(said[pos],"س",2)) indexo=replace_stringex(said[pos], 191-pos, "س", "ﺳ")
    else if(equali(said[pos],"ش",2)) indexo=replace_stringex(said[pos], 191-pos, "ش", "ﺷ")
    else if(equali(said[pos],"ص",2)) indexo=replace_stringex(said[pos], 191-pos, "ص", "ﺻ")
    else if(equali(said[pos],"ض",2)) indexo=replace_stringex(said[pos], 191-pos, "ض", "ﺿ")
    else if(equali(said[pos],"ع",2)) indexo=replace_stringex(said[pos], 191-pos, "ع", "ﻋ")
    else if(equali(said[pos],"غ",2)) indexo=replace_stringex(said[pos], 191-pos, "غ", "ﻏ")
    else if(equali(said[pos],"ف",2)) indexo=replace_stringex(said[pos], 191-pos, "ف", "ﻓ")
    else if(equali(said[pos],"ق",2)) indexo=replace_stringex(said[pos], 191-pos, "ق", "ﻗ")
    else if(equali(said[pos],"ك",2)) indexo=replace_stringex(said[pos], 191-pos, "ك", "ﻛ")
    else if(equali(said[pos],"م",2)) indexo=replace_stringex(said[pos], 191-pos, "م", "ﻣ")
    else if(equali(said[pos],"ن",2)) indexo=replace_stringex(said[pos], 191-pos, "ن", "ﻧ")
    else if(equali(said[pos],"ي",2)) indexo=replace_stringex(said[pos], 191-pos, "ي", "ﻳ")
    else if(equali(said[pos],"ى",2)) indexo=replace_stringex(said[pos], 191-pos, "ى", "ﻰ")
    else if(equali(said[pos],"ه",2)) indexo=replace_stringex(said[pos], 191-pos, "ه", "ﻫ")
    else if(equali(said[pos],"ل",2)) indexo=replace_stringex(said[pos], 191-pos, "ل", "ﻟ")
    else if(equali(said[pos],"ئ",2)) indexo=replace_stringex(said[pos], 191-pos, "ئ", "ﺋ")
    if(indexo!=-1) return true
    else return false
}

stock end_replace(said[],pos) 
{
    new indexo=-1;
    if(equali(said[pos],"ع",2)) indexo=replace_stringex(said[pos], 191-pos, "ع", "ﻊ")
    else if(equali(said[pos],"غ",2)) indexo=replace_stringex(said[pos], 191-pos, "غ", "ﻎ")
    else if(equali(said[pos],"ك",2)) indexo=replace_stringex(said[pos], 191-pos, "ك", "ﻙ")
    else if(equali(said[pos],"ي",2)) indexo=replace_stringex(said[pos], 191-pos, "ي", "ﻲ")
    else if(equali(said[pos],"ة",2)) indexo=replace_stringex(said[pos], 191-pos, "ة", "ﺔ")
    else if(equali(said[pos],"ى",2)) indexo=replace_stringex(said[pos], 191-pos, "ى", "ﻰ")
    else if(equali(said[pos],"ه",2)) indexo=replace_stringex(said[pos], 191-pos, "ه", "ﻪ")
    if(indexo!=-1) return true
    else return false

}

stock ReverseString(toggle[]) 
{ 
    for(new i = strlen(toggle) - 1, j = 0, temp ; i > j ; i--, j++) 
    { 
        temp = toggle[i]; 
        toggle[i] = toggle[j]; 
        toggle[j] = temp; 
    } 
}

stock ReverseString2(toggle[],pos_init,pos_end) 
{ 
    for(new i = pos_end, j = pos_init, temp ; i > j ; i--, j++) 
    { 
        temp = toggle[i]; 
        toggle[i] = toggle[j]; 
        toggle[j] = temp; 
    } 
}

stock MultiByteToWideChar(const mbszInput[], wcszOutput[])
{ 
    new nOutputChars = 0; 
    for (new n = 0; mbszInput[n] != EOS; n++) { 
        if (mbszInput[n] < 0x80) { // 0... 1-byte ASCII 
            wcszOutput[nOutputChars] = mbszInput[n]; 
        } else if ((mbszInput[n] & 0xE0) == 0xC0) { // 110... 2-byte UTF-8 
            wcszOutput[nOutputChars] = (mbszInput[n] & 0x1F) << 6; // Upper 5 bits 
             
            if ((mbszInput[n + 1] & 0xC0) == 0x80) { // Is 10... ? 
                wcszOutput[nOutputChars] |= mbszInput[++n] & 0x3F; // Lower 6 bits 
            } else { // Decode error 
                wcszOutput[nOutputChars] = '?'; 
            } 
        } else if ((mbszInput[n] & 0xF0) == 0xE0) { // 1110... 3-byte UTF-8 
            wcszOutput[nOutputChars] = (mbszInput[n] & 0xF) << 12; // Upper 4 bits 
             
            if ((mbszInput[n + 1] & 0xC0) == 0x80) { // Is 10... ? 
                wcszOutput[nOutputChars] |= (mbszInput[++n] & 0x3F) << 6; // Middle 6 bits 
                 
                if ((mbszInput[n + 1] & 0xC0) == 0x80) { // Is 10... ? 
                    wcszOutput[nOutputChars] |= mbszInput[++n] & 0x3F; // Lower 6 bits 
                } else { // Decode error 
                    wcszOutput[nOutputChars] = '?'; 
                } 
            } else { // Decode error 
                wcszOutput[nOutputChars] = '?'; 
            } 
        } else { // Decode error 
            wcszOutput[nOutputChars] = '?'; 
        } 
         
        nOutputChars++; 
    } 
    wcszOutput[nOutputChars] = EOS; 
}

stock WideCharToMultiByte(const wcszInput[], mbszOutput[])
{ 
    new nOutputChars = 0; 
    for (new n = 0; wcszInput[n] != EOS; n++) { 
        if (wcszInput[n] < 0x80) { 
            mbszOutput[nOutputChars++] = wcszInput[n]; 
        } else if (wcszInput[n] < 0x800) { 
            mbszOutput[nOutputChars++] = (wcszInput[n] >> 6) | 0xC0; 
            mbszOutput[nOutputChars++] = (wcszInput[n] & 0x3F) | 0x80; 
        } else { 
            mbszOutput[nOutputChars++] = (wcszInput[n] >> 12) | 0xE0; 
            mbszOutput[nOutputChars++] = ((wcszInput[n] >> 6) & 0x3F) | 0x80; 
            mbszOutput[nOutputChars++] = (wcszInput[n] & 0x3F) | 0x80; 
        } 
    } 
    mbszOutput[nOutputChars] = EOS; 
}

stock isEnglish(const szString[])
{
    new i = 0;
    new ch;
    while((ch = szString[i]) != EOS)
    {
        if(0x21 <= ch <= 0x7F)
            return true;
        
        i++;
    }

    return false;
}

stock finishing_para(szString[]){
    new i = 0;
    new ch;
    new begin=0,end=0,cpt=0;
    while((ch = szString[i]) != EOS)
    {
        if (ch < 0x80) {
            if(cpt==0){
                begin=i
            }
            cpt++;
        }
        else {
            if (cpt>0){
                end=i-1;
                if(szString[i-1]==0x20){
                    if(i-2>=0 && szString[i-2]<0x80){
                        end=i-2;
                        ReverseString2(szString,begin,end)
                    }
                }
                else{
                    ReverseString2(szString,begin,end)
                }
            }
            cpt=0;
        }
        i++;
    }

}


stock replacer_ar(szString[]){
    new cpt=0;
    new i=0;
    while(i+1<strlen(szString)){
        if(!has_Arabic(szString[i])){
            if(cpt>0){
                if(end_replace(szString,i-2)){

                    i++;
                }
            }
            cpt=0;
        }
        else{
            if(cpt==0){
                if(first_replace(szString,i)){
                    i++;
                }
                
            }
            else if(cpt>0){
                if(i+3<strlen(szString)){                  
                    if(has_Arabic(szString[i+2])){
                        if(middle_replace(szString,i)){
                            i++
                        }
                        
                    }
                }
                else{
                    if(end_replace(szString,i)){
                        i++
                    }           
                }         
            }
            cpt++;
            i++;
        }
        i++;
    }
}