﻿
autostartLnk:=A_StartupCommon . "\my_ahk.lnk"
mask_lnk := A_AppData . "\my_ahk_file.txt"

;-----管理员权限------------
get_admin() {
    full_command_line := DllCall("GetCommandLine", "str")
    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        try
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }
    return
}
if (FileExist(mask_lnk)){
    Loop, read, %mask_lnk%
        last_line := A_LoopReadLine
    if (last_line == A_ScriptFullpath) {

    } else {
        get_admin()
        FileAppend, `n%A_ScriptFullpath%, %mask_lnk%
    }
} else {
    get_admin()
    FileAppend, `n%A_ScriptFullpath%, %mask_lnk%
    ; ToolTip,  %A_ScriptFullpath%"\n   " %mask_lnk%
}
RunAsTask()

;------开机启动------------
Menu, Tray, NoStandard
Menu, Tray, Add, 开机启动, MenuHandler
if (FileExist(autostartLnk)) {
    Menu, Tray, Check, 开机启动
} else {
    Menu, Tray, Uncheck, 开机启动
}
Menu, Tray, Add, 退出, Menu_exit_Handler
return

MenuHandler:
if (FileExist(autostartLnk)) {
    FileDelete, %autostartLnk%
    Menu, Tray, Uncheck, 开机启动
} else {
    FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir%
    Menu, Tray, Check, 开机启动
}
return
Menu_exit_Handler:
ExitApp
return

#IfWinActive ahk_exe YuanShen.exe

~$F::
{
    ; if (GetKeyState("CapsLock", "T") == 0) {
    ;     send f
    ; } else {
    ;     send F
    ; }
    Loop
    {
        state:=GetKeyState("F","P")
        if(state == 0) ;F按键松开
        {
            return
        }
        if(A_TimeSinceThisHotkey > 400) ;F按键时长大于400毫秒
        {
            break
        }
        sleep, 20
    }
    if(state == 0) ;短按
    {         
        ; if (GetKeyState("CapsLock", "T") == 0) {
        ;     send f
        ; } else {
        ;     send F
        ; }
    }
    else ;长按
    {
        N := 0
        click_n := 0
        Random, x, 1296, 1448
        Random, y, 784, 817
        
        Loop 
        {
            state:=GetKeyState("F","P")
            if (state == 1)
            {
                N -= 1
                if (N <= 0) {
                    send f
                    Random, tmp,150, 250
                    N := Ceil(%tmp% / 20)
                }
                click_n -= 1
                if (click_n <= 0) {
                    MouseClick, left, %x%, %y%, 1,5
                    Random, tmp,150, 250
                    click_n := Ceil(%tmp% / 20)
                }
            }
            else
            {
                break
            }
            sleep 20
        }
    }
    return
}
$^7::
{
    Reload
    return
}
$F4::
{
    ; PixelGetColor, color, 103, 37
    ; ToolTip, %color%
    ; return
    Random, x, 1296, 1448
    Random, y, 784, 817
    Loop 
    {
        PixelGetColor, color, 103, 37
        if (color != "0xD8E5EC") {
            Sleep 800
        }
        PixelGetColor, color, 1759, 61
        ; StringRight color,color,6
        ; ToolTip, %color%
        if (color == "0xFFFFFF") {
            break
        }
        N -= 1
        if (N <= 0) {
            send f
            Random, tmp,150, 300
            N := Ceil(%tmp% / 20)
        }
        click_n -= 1
        if (click_n <= 0) {
            MouseClick, left, %x%, %y%, 1, 5
            Random, tmp,150, 300
            click_n := Ceil(%tmp% / 20)
        }
        sleep 20
    }
    return
}

$F3::
{
    ; WinActivate, 原神 ahk_class UnityWndClass
    ; 运动到任务点
    ; Send, {2 Down}
    ; Sleep, 140
    ; Send, {2 Up}
    ; Sleep, 360
    ; Send, {2 Down}
    ; Sleep, 140
    ; Send, {2 Up}
    ; Sleep, 360
    ; Send, {w Down}
    ; Sleep, 93
    ; Send, {LShift Down}
    ; Sleep, 1422
    ; Send, {Space Down}
    ; Sleep, 172
    ; Send, {Space Up}
    ; Sleep, 500
    ; Send, {LShift Up}
    ; Sleep, 172
    ; Send, {LShift Down}
    ; Sleep, 578
    ; Send, {LShift Up}
    ; Sleep, 313
    ; Send, {LShift Down}
    ; Sleep, 1156
    ; Send, {LShift Up}
    ; Sleep, 547
    ; Send, {LShift Down}
    ; Sleep, 500
    ; Send, {A Down}
    ; Sleep, 515
    ; Send, {A Up}
    ; Sleep, 94
    ; Send, {LShift Up}
    ; Sleep, 172
    ; Send, {LShift Down}
    ; Sleep, 1125
    ; Send, {LShift Up}
    ; Sleep, 266
    ; Send, {LShift Down}
    ; Sleep, 484
    ; Send, {LShift Up}
    ; Sleep, 312
    ; Send, {w Up}
    ; Sleep, 157
    ; Send, {w Down}
    ; Sleep, 328
    ; Send, {w Up}
    ; Sleep, 109
    ; Send, {f Down}
    ; Sleep, 78
    ; Send, {f Up}

    ;领取委托
    ; Send, {f Down}
    ; Sleep, 200
    Loop {
        PixelGetColor, color, 1298, 653
        if (color == "0xFFFFFF") {
            break
        }
        send {f}
        Sleep 200
    }
    MouseClick, left, 1351, 495, 1, 5
    Sleep, 500
    Loop 5{
        MouseClick, left, 914, 739, 1, 5
        Sleep 300
    }
    Sleep, 500
    ;派遣
    Send, {f Down}
    Sleep, 200
    Loop 5{
        send {f}
        Sleep 300
    }
    MouseClick, left, 1341, 669, 1, 5 ;派遣
    Sleep, 200
    MouseClick, left, 138, 160, 1, 5 ;蒙德
    Sleep, 50
    MouseClick, left, 1051, 335, 1, 5 ;一号+
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 500
    MouseClick, left, 1219, 901, 1, 5 ; 空白
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 50
    MouseClick, left, 479, 141, 1, 5 ; 一号人物
    Sleep, 50

    MouseClick, left, 1109, 457, 1, 5 ;一号+
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 500
    MouseClick, left, 1219, 901, 1, 5 ; 空白
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 200
    MouseClick, left, 534, 273, 1, 5 ; 一号人物
    Sleep, 50

    MouseClick, left, 1161, 659, 1, 5 ;一号+
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 500
    MouseClick, left, 1219, 901, 1, 5 ; 空白
    Sleep, 50
    MouseClick, left, 1649, 1025, 1, 5 ;确定
    Sleep, 50
    MouseClick, left, 563, 375, 1, 5 ; 一号人物
    Sleep, 50

    send {ESC}
    Sleep, 200
    send {ESC}
    Sleep, 1800
    send {ALT DOWN}
    Sleep, 100
    MouseClick, left, 1482, 47, 1, 5
    Sleep, 500
    send {ALT UP}
    MouseClick, left, 965, 55, 1, 5
    Sleep, 200
    MouseClick, left, 1711, 977, 1, 5
    return
}
$^9::
{
    MouseClick, left, 1714, 768, 1, 2
    Sleep, 200
    MouseClick, left, 1696, 1023, 1, 2
    Sleep, 200
    MouseClick, left, 147, 159, 1, 2
    Sleep, 200
    MouseClick, left, 133, 222, 1, 2
    Sleep, 200
}

watie_util_normal() {
    Loop 
    {
        PixelGetColor, color, 1759, 61
        ; StringRight color,color,6
        ; ToolTip, %color%
        if (color == "0xFFFFFF") {
            break
        }
        sleep 20
    }
    return
}


RunAsTask() {                         ;  By SKAN,  http://goo.gl/yG6A1F,  CD:19/Aug/2014 | MD:24/Apr/2020

  Local CmdLine, TaskName, TaskExists, XML, TaskSchd, TaskRoot, RunAsTask
  Local TASK_CREATE := 0x2,  TASK_LOGON_INTERACTIVE_TOKEN := 3 

  Try TaskSchd  := ComObjCreate( "Schedule.Service" ),    TaskSchd.Connect()
    , TaskRoot  := TaskSchd.GetFolder( "\" )
  Catch
      Return "", ErrorLevel := 1    
  
  CmdLine       := ( A_IsCompiled ? "" : """"  A_AhkPath """" )  A_Space  ( """" A_ScriptFullpath """"  )
  TaskName      := "[RunAsTask] " A_ScriptName " @" SubStr( "000000000"  DllCall( "NTDLL\RtlComputeCrc32"
                   , "Int",0, "WStr",CmdLine, "UInt",StrLen( CmdLine ) * 2, "UInt" ), -9 )

  Try RunAsTask := TaskRoot.GetTask( TaskName )
  TaskExists    := ! A_LastError 


  If ( not A_IsAdmin and TaskExists )      { 

    RunAsTask.Run( "" )
    ExitApp

  }

  If ( not A_IsAdmin and not TaskExists )  { 

    Run *RunAs %CmdLine%, %A_ScriptDir%, UseErrorLevel
    ExitApp

  }

  If ( A_IsAdmin and not TaskExists )      {  

    XML := "
    ( LTrim Join
      <?xml version=""1.0"" ?><Task xmlns=""http://schemas.microsoft.com/windows/2004/02/mit/task""><Regi
      strationInfo /><Triggers /><Principals><Principal id=""Author""><LogonType>InteractiveToken</LogonT
      ype><RunLevel>HighestAvailable</RunLevel></Principal></Principals><Settings><MultipleInstancesPolic
      y>Parallel</MultipleInstancesPolicy><DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries><
      StopIfGoingOnBatteries>false</StopIfGoingOnBatteries><AllowHardTerminate>false</AllowHardTerminate>
      <StartWhenAvailable>false</StartWhenAvailable><RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAva
      ilable><IdleSettings><StopOnIdleEnd>true</StopOnIdleEnd><RestartOnIdle>false</RestartOnIdle></IdleS
      ettings><AllowStartOnDemand>true</AllowStartOnDemand><Enabled>true</Enabled><Hidden>false</Hidden><
      RunOnlyIfIdle>false</RunOnlyIfIdle><DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteApp
      Session><UseUnifiedSchedulingEngine>false</UseUnifiedSchedulingEngine><WakeToRun>false</WakeToRun><
      ExecutionTimeLimit>PT0S</ExecutionTimeLimit></Settings><Actions Context=""Author""><Exec>
      <Command>""" ( A_IsCompiled ? A_ScriptFullpath : A_AhkPath ) """</Command>
      <Arguments>" ( !A_IsCompiled ? """" A_ScriptFullpath  """" : "" )   "</Arguments>
      <WorkingDirectory>" A_ScriptDir "</WorkingDirectory></Exec></Actions></Task>
    )"    

    TaskRoot.RegisterTask( TaskName, XML, TASK_CREATE, "", "", TASK_LOGON_INTERACTIVE_TOKEN )

  }         

Return TaskName, ErrorLevel := 0
} ; _____________________________________________________________________________________________________C:\Users\String\AppData\Roaming\my_ahk_file.txt"\n"