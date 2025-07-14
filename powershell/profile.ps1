[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

# Enabling vim mode in Powershell
Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator Cursor
# Set up jj to escape Insert mode
Set-PSReadLineKeyHandler -Chord 'j,j' -Function ViCommandMode -ViMode Insert

Function Run-Azurite { azurite --silent --location c:\azurite --debug c:\azurite\debug.log --skipApiVersionCheck }
Set-Alias -Name azrt -Value Run-Azurite

Function UseNode16 { nvm use 16.13.2 }
Set-Alias -Name un16 -Value UseNode16

Function UseNode20 { nvm use 20.13.1 }
Set-Alias -Name un20 -Value UseNode20

$endorRootFolder = "D:\CoreBridge\repos\Endor"
$ecommRootFolder = "D:\Corebridge\repos\Ecomm"

$processDictionary = @{
    "api" = "Endor.Api.Web"
    "auth" = "Endor.Auth.Web"
    "boardapi" = "Endor.BoardApi.Web"
    "comms" = "Endor.Comm.Web"
    "integrations" = "Endor.Integrations.Web"
    "logging" = "Endor.Logging.Web"
    "reporting" = "Endor.Reporting.Web"
    "rtc" = "Endor.RTC.Core.Web"
    "rtcpeerhost" = "Endor.RTC.PeerHost.Web"
    "search" = "Endor.Search.Web"
    "tasks" = "Endor.Tasks.Web"
    "ape" = "APE"
    "ate" = "ATE"
}

Function CheckoutAndRunEndor([string]$branchID, [string]$project, [switch]$all) 
{ 
	write-host -ForegroundColor green "Checkout and Run Endor on Feature Branch END-$branchID"
	D:
	cd $endorRootFolder
	
	# Build the command string
    $command = "py cb.py -c END-$branchID"
    
    # Add project parameter if specified
    if (-not [string]::IsNullOrWhiteSpace($project)) {
        $command += " -s $project -basic"
    } else {
        $command += " -s"
    }
	
	if ($all) {
		$command += " -all"
	}
    
    # Display the command that will be executed (optional)
    Write-Host "Executing: $command" -ForegroundColor Cyan
    
    # Execute the command
    Invoke-Expression $command
}
Set-Alias -Name crefb -Value CheckoutAndRunEndor

Function CheckoutEndorFeatureBranch([string]$branchID) 
{ 
	write-host -ForegroundColor green "Checkout Endor on Feature Branch END-$branchID"
	D:
	cd $endorRootFolder
	py cb.py -c END-$branchID
}
Set-Alias -Name cefb -Value CheckoutEndorFeatureBranch

Function CheckoutAndRunEndorDev([string]$project = "")
{ 
	write-host -ForegroundColor blue "Checkout and Run Endor on dev branch"
	D:
	cd $endorRootFolder
	if (-not [string]::IsNullOrWhiteSpace($project)) {
        py cb.py -c dev -s $project
    } else {
        py cb.py -c dev -s
    }
}
Set-Alias -Name cred -Value CheckoutAndRunEndorDev

Function RunEndor([string]$project = "") 
{ 
    D:
    cd $endorRootFolder
    if (-not [string]::IsNullOrWhiteSpace($project)) {
		Write-Host -ForegroundColor Green "Run $project"
        py cb.py -s $project
    } else {
		Write-Host -ForegroundColor Green "Run Endor"
        py cb.py -s
    }
}
Set-Alias -Name re -Value RunEndor

Function ChangeToEndorDirectory([string]$projectName) 
{ 
	write-host -ForegroundColor green "Changed to Endor directory"
	D:
	cd $endorRootFolder
	
	$folderDictionary = @{
        "api"              = "end-api"
        "auth"             = "end-auth"
        "boardapi"         = "end-boardapi"
        "comms"            = "end-comms"
        "integrations"     = "end-integrations"
        "logging"          = "end-logging"
        "reporting"        = "end-reporting"
        "rtc"              = "end-rtc"
        "rtcpeerhost"      = "end-rtcpeerhost"
        "search"           = "end-search-core"
        "tasks"            = "end-tasks"
        "ape"              = "end-ape"
        "analyticreports"  = "end-analyticreports"
        "ate"              = "end-ate"
        "common"           = "end-common"
        "dmaid"            = "end-dm-aid"
        "documentreports"  = "end-documentreports"
        "nglibrary"        = "end-nglibrary"
        "web"              = "end-web"
        "apefrontend"      = "end-ape\APE\Frontend"
    }
	
	if ($projectName -and $folderDictionary.ContainsKey($projectName)) {
        $targetFolder = $folderDictionary[$projectName]
        Set-Location $targetFolder
        Write-Host -ForegroundColor Cyan "Opened: $targetFolder"
    } elseif ($projectName) {
        Write-Host -ForegroundColor Red "Project '$projectName' not found in dictionary."
    }
}
Set-Alias -Name cde -Value ChangeToEndorDirectory

Function TextToBinary([string]$text = "") 
{ 
    D:
	cd D:\python
    py random.py $text
}
Set-Alias -Name ttb -Value TextToBinary

Function RunEcommAdmin()
{
	write-host -ForegroundColor green "Run Ecomm Admin"
	D:
	cd D:\Corebridge\repos\Ecomm\ecomm-admin
	npm start
}
Set-Alias -Name reca -Value RunEcommAdmin

function CheckEndorProcessesRunning {
    param (
        [switch]$all
    )

    # Define the default list of keys to check when -all is not used
    $defaultKeys = @("api", "auth", "integrations", "rtc", "rtcpeerhost", "search")

    # Determine which keys to check
    $keysToCheck = if ($all) { $processDictionary.Keys } else { $defaultKeys }

    # Get running process names
    $runningProcesses = Get-Process | Select-Object -ExpandProperty ProcessName

    # Track missing process keys
    $missingProcessKeys = @()

    foreach ($category in $keysToCheck) {
        $process = $processDictionary[$category]
        if ($process -notin $runningProcesses) {
            $missingProcessKeys += $category
            Invoke-Expression "re $category"
        }
    }

    if ($missingProcessKeys.Count -eq 0) {
        Write-Host "All checked Endor processes are running." -ForegroundColor Green
    } else {
        Write-Host "The following process categories were NOT running:" -ForegroundColor Red
        $missingProcessKeys | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    }
}

Set-Alias -Name cepr -Value CheckEndorProcessesRunning

Function KillProcessByName([string]$processName = "")
{
    # If no process name provided, kill all processes in the dictionary
    if ([string]::IsNullOrEmpty($processName)) {
        Write-Host -ForegroundColor Yellow "Killing all Endor processes"
        
        foreach ($key in $processDictionary.Keys) {
            $actualProcessName = $processDictionary[$key]
                        
			$processes = Get-Process -Name $actualProcessName -ErrorAction SilentlyContinue
			if ($processes) {
				Stop-Process -InputObject $processes -Force
				Write-Host -ForegroundColor Blue "Process '$actualProcessName' was killed"
			} else {
				Write-Host -ForegroundColor Gray "Process '$actualProcessName' is not running"
			}
        }
    }
    # If a process name is provided, kill just that one
    else {
        if ($processDictionary.ContainsKey($processName)) {
            $actualProcessName = $processDictionary[$processName]
                        
			$processes = Get-Process -Name $actualProcessName -ErrorAction SilentlyContinue
			if ($processes) {
				Stop-Process -InputObject $processes -Force
				Write-Host -ForegroundColor Blue "Process '$actualProcessName' was killed"
			} else {
				Write-Host -ForegroundColor Yellow "Process '$actualProcessName' is not running"
			}
        } else {
            Write-Host -ForegroundColor Red "Process name '$processName' not found in the dictionary"
        }
    }
}

# Set up an alias 'kp' for the function
Set-Alias -Name kp -Value KillProcessByName

Function OpenInRider([string]$projectName = "")
{
    $projectSolutions = @{
        "ape"           = "$endorRootFolder\end-ape\APE.sln"
        "api"           = "$endorRootFolder\end-api\Endor.Api.sln"
        "ate"           = "$endorRootFolder\end-ate\ATE.sln"
        "auth"          = "$endorRootFolder\end-auth\Endor.Auth.sln"
        "boardapi"      = "$endorRootFolder\end-boardapi\Endor.BoardApi.sln"
        "common-kernel" = "$endorRootFolder\end-common\Endor.Common.Kernel.sln"
        "common-level1" = "$endorRootFolder\end-common\Endor.Common.Level1.sln"
        "common-level2" = "$endorRootFolder\end-common\Endor.Common.Level2.sln"
        "comms"         = "$endorRootFolder\end-comms\Endor.Comm.sln"
        "integrations"  = "$endorRootFolder\end-integrations\Endor.Integrations.sln"
        "rtc"           = "$endorRootFolder\end-rtc\END-RTC-Core.sln"
        "rtcpeerhost"   = "$endorRootFolder\end-rtcpeerhost\END-RTCPeerHost.sln"
        "search"        = "$endorRootFolder\end-search-core\Endor.Search.sln"
        "tasks"         = "$endorRootFolder\end-tasks\Endor.Tasks.sln"
        "ec"            = "$ecommRootFolder\ecomm-api-storefront\trunk\WebApps\Znode\Projects\Znode.Multifront.sln"
        "cbms"          = "$ecommRootFolder\corebridgefiles\trunk\WebApps\ManagementSystem\Management System.sln"
    }

    # Check if the string parameter is null, empty, or whitespace
    if ([string]::IsNullOrWhiteSpace($projectName)) {
        Write-Error "Error: Required projectName parameter was not provided."
        return
    }

	Write-Host -ForegroundColor Blue "Opening '$projectName' in Rider"
	
    $solutionPath = $projectSolutions[$projectName]
    rider64 $solutionPath
}

# Set up an alias 'kp' for the function
Set-Alias -Name oir -Value OpenInRider

Function OpenInCursor([string]$projectName = "")
{
    $projectPaths = @{
		"apefrontend"   = "$endorRootFolder\end-ape\APE\Frontend"
		"ape"           = "$endorRootFolder\end-ape\APE"
        "api"           = "$endorRootFolder\end-api"
        "ate"           = "$endorRootFolder\end-ate"
        "auth"          = "$endorRootFolder\end-auth"
        "boardapi"      = "$endorRootFolder\end-boardapi"
        "common-kernel" = "$endorRootFolder\end-common"
        "common-level1" = "$endorRootFolder\end-common"
        "common-level2" = "$endorRootFolder\end-common"
        "comms"         = "$endorRootFolder\end-comms"
        "integrations"  = "$endorRootFolder\end-integrations"
        "rtc"           = "$endorRootFolder\end-rtc"
        "rtcpeerhost"   = "$endorRootFolder\end-rtcpeerhost"
        "search"        = "$endorRootFolder\end-search-core"
        "tasks"         = "$endorRootFolder\end-tasks"
        "web"           = "$endorRootFolder\end-web"
        "ec"            = "$ecommRootFolder\ecomm-api-storefront\trunk\WebApps\Znode\Projects"
        "eca"           = "$ecommRootFolder\ecomm-admin"
        "cbms"          = "$ecommRootFolder\corebridgefiles\trunk\WebApps\ManagementSystem"
    }

    # Check if the string parameter is null, empty, or whitespace
    if ([string]::IsNullOrWhiteSpace($projectName)) {
        Write-Error "Error: Required projectName parameter was not provided."
        return
    }

	Write-Host -ForegroundColor Blue "Opening '$projectName' in Cursor"
	
    $solutionPath = $projectPaths[$projectName]
    cursor $solutionPath
}

# Set up an alias 'kp' for the function
Set-Alias -Name oic -Value OpenInCursor

Function CreateElixirModuleAndTestFiles([string]$moduleName)
{
	$rootFolder = Get-Location
	
	if (-not ([string]::IsNullOrEmpty($rootFolder)) -And -not ([string]::IsNullOrEmpty($moduleName)))
	{
		# Parse module name to snake case
		$fileName = [regex]::replace($moduleName, '(?<=.)(?=[A-Z])', '_').ToLower()

		$moduleFileName = "$fileName.ex"
		$testFileName = "$fileName" + "_test.exs"
		
		$inputFolderPath = "$rootFolder\inputs\$fileName"
		$inputTestFilePath = "$inputFolderPath\test_input.txt"
		$inputChallengeFilePath = "$inputFolderPath\challenge_input.txt"

		$moduleFilePath = "$rootFolder\lib\$moduleFileName"
		$testFilePath = "$rootFolder\test\$testFileName"

		$defaultModuleContent = @"
defmodule $moduleName do
	def part_one(input) do
	
	end
	
	def part_two(input) do
	
	end
end
"@

		$testModuleName = $moduleName + "Test"

		$testModuleContent = @"
defmodule $testModuleName do
	use ExUnit.Case
	
	test "$moduleName - test part one" do
    assert File.read!("./inputs/$fileName/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> $moduleName.part_one() == 0
	end
	
	# test "$moduleName - challenge part one" do
    # assert File.read!("./inputs/$fileName/challenge_input.txt")
    #        |> String.split("\r\n", trim: true)
    #        |> $moduleName.part_one()
    #        |> IO.inspect(label: "$moduleName - challenge one")
	# end

	# test "$moduleName - test part two" do
	# 	assert File.read!("./inputs/$fileName/test_input.txt")
	# 	   |> String.split("\r\n", trim: true)
	# 	   |> $moduleName.part_two() == 0
	# end

	#test "$moduleName - challenge part two" do
	#	assert File.read!("./inputs/$fileName/challenge_input.txt")
	#	   |> String.split("\r\n", trim: true)
	#	   |> $moduleName.part_two()
	#	   |> IO.inspect(label: "$fileName - challenge two")
	#end
end
"@

		# Create the module file at the lib folder
		New-Item -Path $moduleFilePath
		write-host -ForegroundColor green "Generated Elixir Module file $fileNameSnakeCase.ex at $moduleFilePath"

		# Create the module file at the lib folder
		New-Item -Path $testFilePath
		write-host -ForegroundColor green "Generated Test file $fileNameSnakeCase.exs at $testFilePath"

		# Set default module content to module file
		Set-Content -Path $moduleFilePath -Value $defaultModuleContent
		
		# Set default test module content in the test file
		Set-Content -Path $testFilePath -Value $testModuleContent
		
		# Create the module file at the lib folder
		New-Item -Path $inputFolderPath -ItemType Directory
		write-host -ForegroundColor green "Generated input folder at $inputFolderPath"
		
		New-Item -Path $inputTestFilePath 
		New-Item -Path $inputChallengeFilePath 
		write-host -ForegroundColor green "Generated input txt files at $inputFolderPath"
	} 
	else
	{
		Throw "Por favor informe uma pasta e o nome do módulo"
	}
}

Set-Alias -Name cemtf -Value CreateElixirModuleAndTestFiles

function EditNvimConfig {
    $configPath = "$env:LOCALAPPDATA\nvim\init.lua"
    
    # Check if the config file exists, if not create the directory and file
    if (!(Test-Path $configPath)) {
        $configDir = Split-Path $configPath -Parent
        if (!(Test-Path $configDir)) {
            New-Item -ItemType Directory -Path $configDir -Force
        }
        New-Item -ItemType File -Path $configPath -Force
    }
    
    nvim $configPath
}

# Create an alias for the function
Set-Alias -Name envc -Value EditNvimConfig

function RemoveFolder {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    if (Test-Path $Path) {
        Remove-Item -Recurse -Force -Path $Path
        Write-Output "Deleted: $Path"
    } else {
        Write-Warning "Path does not exist: $Path"
    }
}

Set-Alias -Name rmdir -Value RemoveFolder 

Invoke-Expression (&starship init powershell)
