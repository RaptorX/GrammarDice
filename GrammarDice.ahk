global       numbers := "234352"
    , vowels := "AEEIOU"
    , partsofspeech := "Adj.|Adv.|Prep.|Pron.|Inj.|Conj."
    , punctuation := ":|?|,|( )|""""|;"
    , consonants := "BCDFGRHJKSLMNPRSTVLW"
    , voiceform := "Active|Passive"
    , tenses := "Simple Past|Simple Present|Simple Future|Past Progressive|Present Progressive|Future Progressive|Past Perfect|Present Perfect|Future Perfect|Past Perfect Progressive|Present Perfect Progressive|Future Perfect Progressive"
    , topics := ""


Gui add, checkbox, vc_min, Minimum
Gui add, checkbox, x+10 yp vc_pos, Parts of Speech
Gui add, checkbox, x+10 yp vc_punct, Punctuation
Gui add, checkbox, x+10 yp vc_tense, Tenses
Gui add, checkbox, x+10 yp vc_voiceform, Speech Mode
Gui add, checkbox, disabled x+10 yp vc_topic, Topic

Gui font, s30
Gui add, text, border center HWNDtxt_hwnd1 w900 h50 x10 yp+25, % "Press the button to get a random sentence code."
gui font
Gui add, button, x+10 yp w75 h50 gRoll, % "Roll the dice!"
Gui show

Return 

Roll:
start_time = %a_tickcount%
Gui Submit, nohide

clipboard 	:= code := c:=get("consonant") v:=get("vowel")
			. (c_min ? n:=get("number") : null)
			. (c_pos ? po:= " [" get("pos") "]" : null)
			. (c_punct ? pu:= " " get("punctuation") : null)
			. (c_tense ? t:= " {" get("tense") "}" : null)
			. (c_voiceform ? vf:= " [" get("voiceform") "]" : null)
			. (c_topic ? tp:= " [" get("topic") "]" : null)

ControlSetText,, %code%, ahk_id %txt_hwnd1%

Return



get(type)
{
    
    Random,, a_tickcount

    if (type = "consonant"){

        Random, r_consonants,1,20
        Loop, parse, consonants
        {
            ret := a_loopfield
            if (a_index = r_consonants)
                break
        }

    } else if (type = "vowel"){

        Random, r_vowels,1,6
        Loop, parse, vowels
        {
            ret := a_loopfield
            if (a_index = r_vowels)
                break
        }

    } else if (type = "number"){

        Random, r_numbers,1,6
        Loop, parse, numbers
        {
            ret := a_loopfield
            if (a_index = r_numbers)
                break
        }

    } else if (type = "pos"){

        Random, r_partsofspeech,1,6
        Loop, parse, partsofspeech,|
        {
            ret := a_loopfield
            if (a_index = r_partsofspeech)
                break
        }

    } else if (type = "punctuation"){

        Random, r_punctuation,1,6
        Loop, parse, punctuation,|
        {
            ret := a_loopfield
            if (a_index = r_punctuation)
                break
        }

    } else if (type = "voiceform"){

        Random, r_voiceform,1,2
        Loop, parse, voiceform,|
        {
            ret := a_loopfield
            if (a_index = r_voiceform)
                break
        }

    } else if (type = "tense"){

        Random, r_tenses,1,12
        Loop, parse, tenses,|
        {
            ret := a_loopfield
            if (a_index = r_tenses)
                break
        }

    } else if (type = "topic"){

        Random, r_topics,1,12
        Loop, parse, topics,|
        {
            ret := a_loopfield
            if (a_index = r_topics)
                break
        }

    }

    return ret
}