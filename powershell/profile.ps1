[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

# Enabling vim mode in Powershell
Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator Cursor

Function Run-Azurite { azurite --silent --location c:\azurite --debug c:\azurite\debug.log --skipApiVersionCheck }
Set-Alias -Name azrt -Value Run-Azurite

Function UseNode16 { 
    nvm use 16.13.2 
}

Set-Alias -Name un16 -Value UseNode16

Function UseNode20 { nvm use 20.13.1 }
Set-Alias -Name un20 -Value UseNode20

Function UseNode22 {
    nvm use 22.20.0 
}

$corebridgeRootFolder = "D:\CoreBridge\repos"
$endorRootFolder = "D:\CoreBridge\repos\Endor"
$ecommRootFolder = "D:\Corebridge\repos\Ecomm"

$endorProcessDictionary = @{
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

# Processes that only have a generic name (powershell/node), so they are identified by their console window title
$endorWindowTitleDictionary = @{
    "web" = "ng serve (corebridge)"
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
        if ($project -eq "web") {
            UseNode22
        }
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
        if ($project -eq "web") {
            UseNode22
        }
        py cb.py -c dev -s $project
    } else {
        py cb.py -c dev -s
    }
}
Set-Alias -Name cred -Value CheckoutAndRunEndorDev

Function RunEndor([string[]]$project = @()) 
{ 
    D:
    cd $endorRootFolder
    if ($project.Count -gt 0) {
        foreach ($p in $project) {
            if ($p -eq "web") {
                UseNode22
            }

            Write-Host -ForegroundColor Green "Run $p"
            py cb.py -s $p
        }
    } else {
		Write-Host -ForegroundColor Green "Run Endor"
        py cb.py -s
    }
}
Set-Alias -Name re -Value RunEndor

Function RunBasicEndor
{
    $basicProjects = [ordered]@{
        "api"         = "end-api"
        "auth"        = "end-auth"
        "boardapi"    = "end-boardapi"
        "rtc"         = "end-rtc"
        "rtcpeerhost" = "end-rtcpeerhost"
        "search"      = "end-search-core"
        "tasks"       = "end-tasks"
        "web"         = "end-web"
    }

    D:
    cd $endorRootFolder

    foreach ($project in $basicProjects.Keys) {
        if ($project -eq "web") {
            UseNode22
        }

        Write-Host -ForegroundColor Green "Run $project"
        py cb.py -s $project
    }
}
Set-Alias -Name reb -Value RunBasicEndor

Function ChangeToEndorDirectory([string]$projectName) 
{ 
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
        write-host -ForegroundColor green "Changed to Endor directory"
        D:
        cd $endorRootFolder

        $targetFolder = $folderDictionary[$projectName]
        Set-Location $targetFolder
        Write-Host -ForegroundColor Cyan "Opened: $targetFolder"
    } elseif ($projectName) {
        $v2FolderDictionary = @{
            "cbms" = "D:\Corebridge\repos\Ecomm\corebridgefiles\trunk\WebApps\ManagementSystem"
        }
        if ($v2FolderDictionary.ContainsKey($projectName)) {
            $targetFolder = $v2FolderDictionary[$projectName]
            Set-Location $targetFolder
            Write-Host -ForegroundColor Cyan "Opened: $targetFolder"
        } else {
            Write-Host -ForegroundColor Red "Project '$projectName' not found in dictionary."
        }
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
    UseNode16

	write-host -ForegroundColor green "Run Ecomm Admin"
	D:
	cd D:\Corebridge\repos\Ecomm\ecomm-admin
	npm start
}
Set-Alias -Name recadm -Value RunEcommAdmin

Function ChangeToV2CbdMigrationFolder()
{
	write-host -ForegroundColor green "Change to V2 Cdb Migration Folder"
    D:
    cd D:\Corebridge\repos\Ecomm\corebridgefiles\Database\Migrations\CoreBridge.Data.Migrations.Cdb
}

Function RunCdbMigration([string]$databaseName = "") 
{
    ChangeToV2CbdMigrationFolder 

    if ($databaseName) {
        .\BuildAndRunMigrations.ps1 -DatabaseName $databaseName
    } else {
        .\BuildAndRunMigrations.ps1
    }
}
Set-Alias -Name rcbm -Value RunCdbMigration

function CheckEndorProcessesRunning {
    param (
        [switch]$all
    )

    # Define the default list of keys to check when -all is not used
    $defaultKeys = @("api", "auth", "integrations", "rtc", "rtcpeerhost", "search")

    # Determine which keys to check
    $keysToCheck = if ($all) { $endorProcessDictionary.Keys } else { $defaultKeys }

    # Get running process names
    $runningProcesses = Get-Process | Select-Object -ExpandProperty ProcessName

    # Track missing process keys
    $missingProcessKeys = @()

    foreach ($category in $keysToCheck) {
        $process = $endorProcessDictionary[$category]
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

Function StopEndorProcess([string]$processName)
{
    $matchingProcesses = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if (-not $matchingProcesses) {
        Write-Host -ForegroundColor Gray "Process '$processName' is not running"
        return
    }

    $processIds = $matchingProcesses.Id -join ", "
    Write-Host -ForegroundColor Cyan "Found $(@($matchingProcesses).Count) '$processName' process(es), PID: $processIds"

    Stop-Process -InputObject $matchingProcesses -Force
    Write-Host -ForegroundColor Blue "Process '$processName' was killed"
}

Function StopEndorProcessByWindowTitle([string]$windowTitle)
{
    $hostProcesses = Get-Process | Where-Object { $_.MainWindowTitle -eq $windowTitle }
    if (-not $hostProcesses) {
        Write-Host -ForegroundColor Gray "Process '$windowTitle' is not running"
        return
    }

    # npm and ng run as child processes of the window's powershell host, so the whole tree
    # must be killed, otherwise the node dev server keeps running and holding its port
    foreach ($hostProcess in $hostProcesses) {
        taskkill /PID $hostProcess.Id /T /F | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host -ForegroundColor Red "Failed to kill '$windowTitle' (PID $($hostProcess.Id)), try an elevated shell"
            continue
        }
        Write-Host -ForegroundColor Blue "Process '$windowTitle' was killed"
    }
}

Function KillEndorProcessByName([string]$processName = "")
{
    if ([string]::IsNullOrEmpty($processName)) {
        Write-Host -ForegroundColor Yellow "Killing all Endor processes"
        $endorProcessDictionary.Values | ForEach-Object { StopEndorProcess $_ }
        $endorWindowTitleDictionary.Values | ForEach-Object { StopEndorProcessByWindowTitle $_ }
        return
    }

    if ($endorProcessDictionary.ContainsKey($processName)) {
        StopEndorProcess $endorProcessDictionary[$processName]
        return
    }

    if ($endorWindowTitleDictionary.ContainsKey($processName)) {
        StopEndorProcessByWindowTitle $endorWindowTitleDictionary[$processName]
        return
    }

    Write-Host -ForegroundColor Red "Process name '$processName' not found in the dictionary"
}

# Set up an alias 'kep' for the function
Set-Alias -Name kep -Value KillEndorProcessByName

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
        "v2cp"          = "$ecommRootFolder\corebridgefiles\trunk\WebApps\CustomerPortal\CustomerPortal.sln"
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
		"apefe"   = "$endorRootFolder\end-ape\APE\Frontend"
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
        "ecadm"         = "$ecommRootFolder\ecomm-admin"
        "cbms"          = "$ecommRootFolder\corebridgefiles\trunk"
        "ecfe"          = "$ecommRootFolder\ecomm-api-storefront\trunk\WebApps\Znode\Projects\Znode.Engine.MvcDemo\Scripts\Typescripts"
        "v2cp"          = "$ecommRootFolder\corebridgefiles\trunk\WebApps\CustomerPortal"
        "cbdm"          = "$ecommRootFolder\corebridgefiles\Database\Migrations\CoreBridge.Data.Migrations.Cdb"
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
    $configPath = "D:\vscode_vim_settings\nvim\init.lua"
    
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

function EditVimConfig {
    $configPath = "D:\vscode_vim_settings\vim\.vimrc"
    
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
Set-Alias -Name evc -Value EditVimConfig

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

function ApplyStashCbms() {
    D:
    cd $ecommRootFolder\corebridgefiles\trunk\WebApps\ManagementSystem
    git stash apply --index $(git stash list | grep ": Local$" | head -1 | cut -d: -f1)
}

Set-Alias -Name ascbms -Value ApplyStashCbms 

function OpenWorkHoursSpreadSheet() {
    Start-Process "D:\Dropbox\horas-trabalho.xlsx"  
}

Set-Alias -Name owhs -Value OpenWorkHoursSpreadSheet 

function ChangeToDesktop() {
    Set-Location "C:\Users\tiago\OneDrive\Área de Trabalho"
}

Set-Alias -Name cdd -Value ChangeToDesktop 

# arduino-cli settings and aliases
# Set Alias for arduino-cli
Set-Alias -Name adc -Value arduino-cli

function NewArduinoSketch {
    param([string]$Name)

    arduino-cli sketch new $Name

    @"
profiles:
  uno:
    fqbn: arduino:avr:uno
    port: COM6

default_profile: uno
"@ | Set-Content "$Name\sketch.yaml"
}
Set-Alias -Name adcns -Value NewArduinoSketch

# Invoke-Expression (&starship init powershell)

