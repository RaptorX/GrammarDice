/*
 * =============================================================================================== *
 * Author           : Isaias Baez   <graptorx@gmail.com>
 * Script Name      : Grammar Dice
 * Script Version   : 0.1
 * Homepage         : -
 *
 * Creation Date    : Friday, June 06, 2014
 * Modification Date:
 *
 * Description      :
 * ------------------
 *
 * This is a small program that is used to simulate the popular GrammarPunk game.
 * It allows you to randomize the creation of sentences in any language by using a set of rules
 * which in turn can be passed to a student in any language for them to practice.
 *
 * -----------------------------------------------------------------------------------------------
 * License          :       Copyright ©2014 Isaias Baez <GPLv3>
 *
 *          This program is free software: you can redistribute it and/or modify
 *          it under the terms of the GNU General Public License as published by
 *          the Free Software Foundation, either version 3 of  the  License,  or
 *          (at your option) any later version.
 *
 *          This program is distributed in the hope that it will be useful,
 *          but WITHOUT ANY WARRANTY; without even the implied warranty  of
 *          MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the
 *          GNU General Public License for more details.
 *
 *          You should have received a copy of the GNU General Public License
 *          along with this program.  If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>
 * -----------------------------------------------------------------------------------------------
 *
 * [GUI Number Index]
 *
 * GUI 01 -
 *
 * =============================================================================================== *
 */

;[Includes]{
#include *i %a_scriptdir%
#include lib\scriptobj.ahk
;}

;[Directives]{
#NoEnv
#SingleInstance Force
; --
SetBatchLines, -1
SendMode, Input
SetWorkingDir, %a_scriptdir%
OnExit, Exit
; --
TrayMenu() ; This function is here so that Tray Icon is shown early.
;}

;[Basic Script Info]{
script := { base        : scriptobj
           ,name        : "Grammar Dice"
           ,version     : "0.1"
           ,author      : "Isaias Baez"
           ,email       : "graptorx@gmail.com"
           ,homepage    : ""
           ,crtdate     : "Friday, June 06, 2014"
           ,moddate     : ""
           ,conf        : "" } script.getparams()
;}

;[General Variables]{
null        := ""
sec         := 1000                 ; 1 second
min         := 60*sec                  ; 1 minute
hour        := 60*min                  ; 1 hour
;}

;[User Configuration]{

; Trying to fix the issues that result from the script not being run as admin under Win7/Vista
if !a_isadmin
{
    If a_iscompiled
       DllCall(ShellExecute,"Uint", 0
                           , "Str", "RunAs"
                           , "Str", a_scriptfullpath
                           , "Str", params
                           , "Str", a_workingdir
                           ,"Uint", 1)
    Else
       DllCall(ShellExecute,"Uint", 0
                           , "Str", "RunAs"
                           , "Str", a_ahkpath
                           , "Str", """" a_scriptfullpath """" a_space params
                           , "Str", a_workingdir
                           ,"Uint", 1)
    ExitApp
}

system :={}, system.mon :={}, system.wa :={}

RegRead,defBrowser,HKCR,.html                               ; Get default browswer
RegRead,defBrowser,HKCR,%defBrowser%\Shell\Open\Command     ; Get path to default browser + options
SysGet, mon, Monitor                                        ; Get the boundaries of the current screen
SysGet, wa, MonitorWorkArea                                 ; Get the working area of the current screen

system.defBrowser := defBrowser
system.mon.left := monLEFT, system.mon.right := monRIGHT, system.mon.top := monTOP, system.mon.bottom := monBOTTOM
system.wa.left := waLEFT, system.wa.right := waRIGHT, system.wa.top := waTOP, system.wa.bottom := waBOTTOM
;--
; Cleaning
defBrowser:=monLEFT:=monRIGHT:=monTOP:=monBOTTOM:=waLEFT:=waRIGHT:=waTOP:=waBOTTOM:=null  ; Set all to null
;--
; Configuration file objects
conf := ComObjCreate("MSXML2.DOMDocument"), xsl := ComObjCreate("MSXML2.DOMDocument")
style =
(
<!-- Extracted from: http://www.dpawson.co.uk/xsl/sect2/pretty.html (v2) -->
<!-- Cdata info from: http://www.altova.com/forum/default.aspx?g=posts&t=1000002342 -->
<!-- Modified By RaptorX -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
            indent="yes"
            encoding="UTF-8"/>

<xsl:template match="*">
   <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
   </xsl:copy>
</xsl:template>

<xsl:template match="comment()|processing-instruction()">
   <xsl:copy />
</xsl:template>
</xsl:stylesheet>
<!-- I have to keep the indentation here in this file as i want it to be on the XML file -->
)
xsl.loadXML(style), style:=null
if !conf.load(script.conf)
{
    if FileExist(script.conf)
    {
        Msgbox, 0x14
              , % "Error while reading the configuration file."
              , % "The configuration file is corrupt.`n"
                . "Do you want to load the default configuration file?`n`n"
                . "Note: `n"
                . "You will lose any saved hotkeys/hotstrings and all other personal data by this operation.`n"
                . "Choose No to abort the operation and try to recover the file manually."

        IfMsgBox Yes
        {
            Msgbox, 0x40
                  , % "Operation Completed"
                  , % "The default configuration file was successfully created. The script will reload."
            defConf(script.conf)
            Reload
            Pause       ; Fixes the problem of the Main Gui flashing because of being created before
                        ; the Reload is really performed.
        }
        IfMsgBox No
            ExitApp
    }
    else
        FirstRun()
} root:=conf.documentElement,options:=root.firstChild,hotkeys:=options.nextSibling,hotstrings:=hotkeys.nextSibling
;}

;[Main]{

Return                      ; [End of Auto-Execute area]
;}

;[Labels]{
GuiHandler:     ;{
    GuiHandler()
return
;}

MenuHandler:    ;{
    MenuHandler()
return
;}

ListHandler:    ;{
    ListHandler()
return
;}

HotkeyHandler:  ;{
    HotkeyHandler(a_thishotkey)
return
;}

GuiSize:        ;{ Gui Size Handler
return
;}

Exit:
    ExitApp
;}

;[Functions]{
; Gui related functions
FirstRun(){
    return
}
TrayMenu(){
    return
}

; Handlers
GuiHandler(){
    return
}
MenuHandler(stat=0){
    return
}
ListHandler(sParam=0){
    return
}
HotkeyHandler(hk){
    return
}
MsgHandler(wParam,lParam, msg, hwnd){
    return
}
;}

;[Classes]{
;}

;[Hotkeys/Hotstrings]{
^CtrlBreak::Reload
;}
