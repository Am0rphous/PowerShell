<#
Info about your menu script
 #>

    function CatchErrorMessage {
        # `n gives a new line
        # `t makes a tabulator space
        # $_ shows the error message
        # 'Fore' is short for 'ForegroundColor'
        Write-Host "`t$_`n" -Fore Red
    }

    Function Prompt_reload_menu {
        Read-Host "`tPress 'enter'to go back"
        $menuOption = 0 #It's important to reset variable
        LoadMenu
    }

    Function Reload_menu_now {
        $menuOption = 0 #It's important to reset variable
        LoadMenu
    }

Function LoadMenu {
    
    [int] $menuOption = 0        #Resets the menuoptions for each time the menu loads
       $t             = "`t`t"   #Each 't' makes a tab space from the left
       $nt            = "`n`t`t" #Makes a new line and two tabulator spaces
    [int] $LastOption = 6       #Total number of options in the menu
    [string] $MenuBar = "`n=========== PowerShell Menu for SysAdmins==========="

    #Foreach option in the menu, the script checks if the user has chosen
    #a value less than 1 or an option greater than the last menu option.
    #If the value is outside of the menu options, the code in 'default' will
    #excecute.

    while ( $menuOption -lt 1 -or $menuOption -gt $LastOption ) {
        CLS #Clears creen
        Write-Host $MenuBar                            -Fore Magenta
        Write-Host "`n`tgithub.com/Am0rphous" 
        Write-Host "$nt`Choose between these options:" -Fore Cyan
        Write-host "$nt`1. " -NoNewline -Fore Cyan; Write-Host "Option one"
        Write-host "$nt`2. " -NoNewline -Fore Cyan; Write-Host "Option two"
        Write-host "$nt`3. " -NoNewline -Fore Cyan; Write-Host "Option three"
        Write-host "$nt`4. " -NoNewline -Fore Cyan; Write-Host "Option four"
        Write-host "$nt`5. " -NoNewline -Fore Cyan; Write-Host "Option five"
        Write-host "$nt`6. " -NoNewline -Fore Cyan; Write-Host "Exit"

    #Gets input which is supposed to an integer value from the user
    [Int] $menuOption = Read-Host "`n`tOption"
        if ( $menuOption -lt 1 -or $menuOption -gt $LastOption ) {
			Write-Host "$nt`Please choose a number in the menu" -Fore Red
            Sleep -Seconds 2 #Script pauses for two seconds, so the user has time to read the error message
		}

        Write-Host "" #Shows the feedback to the user one line further down
    }

    Switch ( $menuOption ) {

    1 { #Option 1 - whatever

        Try {
            Write-Host "Running your code now .."
            Prompt_reload_menu
         } Catch { CatchErrorMessage }

    } #Option 1 - whatever

    2 { #Option 2 - whatever

        Try {
            Write-Host "Running your code now .."
        } Catch { CatchErrorMessage }

        Prompt_reload_menu

    } #Option 2 - whatever

    3 { #Option 3 - whatever

        Try {
            Write-Host "Running your code now .."
        }
        Catch { CatchErrorMessage }

        Prompt_reload_menu

    } #Option 3 - whatever

    4 { #Option 4 - whatever

        Try {
            Write-Host "Running your code now .."
        }
        Catch { CatchErrorMessage }

        Prompt_reload_menu

    } #Option 4 - whatever

    5 { #Option 5 - whatever

        Try {
            Write-Host "Running your code now .."
        }
        Catch { CatchErrorMessage }

        Prompt_reload_menu

    } #Option 5 - whatever
    
    default { #Code to execute if option number 6 is chosen 
        Write-Host "`t __________________ "
        Write-Host "`t<     Good bye     >"
        Write-Host "`t ------------------"
        Write-Host "`t        \   ^__^"
        Write-Host "`t         \  (oo)\_______"
        Write-Host "`t            (__)\       )\/\"
        Write-Host "`t                ||----w |"
        Write-Host "`t__v_v___v_____v_" -Fore Green -NoNewline
        Write-Host "||"                             -NoNewline
        Write-Host "_____"              -Fore Green -NoNewline
        Write-Host "||"                             -NoNewline
        Write-Host "__`n"               -Fore Green

            exit #Exits script

        } #Code to execute if option number 6 is chosen 

    }#End switch

}#End function

LoadMenu #Calls for the menu
