# ---------------------------------------------------------------------------- #
#                                    ALIASES                                   #
# ---------------------------------------------------------------------------- #

Set-Alias -Name k -Value kubectl
Set-Alias -Name vi -Value nvim
function mkcd($dir) { mkdir $dir -Force; cd $dir }
function programming { cd G:/Programming }
function src { echo "reloading profile file..."; . $PROFILE }

# ---------------------------------------------------------------------------- #
#                                   FUNCTIONS                                  #
# ---------------------------------------------------------------------------- #

function run_c {
	<#
	.SYNOPSIS
		Compiles and runs C/C++ programs
	.DESCRIPTION
		Compiles and runs C/C++ programs with support for single file mode and project mode
	.PARAMETER single_file_mode
		If true, compiles and runs a specific file; otherwise runs in project mode
	.PARAMETER source_file
		Path to the C/C++ file to compile in single file mode
	.PARAMETER args
		Arguments to pass to the program
	.PARAMETER keep_compiled
		If specified, does not remove compiled files after execution
	.PARAMETER verbose
		Show detailed compilation and execution information
	#>
	param (
		[Parameter(Position = 0)]
		[bool]$single_file_mode = $false,

		[Parameter(Position = 1)]
		[string]$source_file,

		[Parameter(Position = 2, ValueFromRemainingArguments)]
		[string[]]$args = @(),

		[switch]$keep_compiled,

		[switch]$verbose
	)

	# Set C++ compiler command and flags
	$cpp_cmd = "g++"
	$cpp_flags = @("-Wall", "-Wextra", "-Wpedantic", "-Werror")
	$output_name = "main"

	if ($verbose) { Write-Host "C++ compilation started at $(Get-Date)" -ForegroundColor Cyan }
	Write-Host "Compiling..." -ForegroundColor Yellow

	if ($single_file_mode) {
		if (Test-Path $source_file) {
			if ($verbose) { Write-Host "Compiling file: $source_file" }
			& $cpp_cmd $cpp_flags $source_file -o $output_name

			if ($LASTEXITCODE -ne 0) {
				Write-Error "Error: compilation failed with exit code $LASTEXITCODE"
				return $LASTEXITCODE
			}
		} else {
			Write-Error "Error: Source file \"$source_file" not found"
			return 1
		}
	} else {
		# Project mode - find all cpp files
		$source_files = Get-ChildItem -Filter "*.cpp" -Recurse

		if ($source_files.Count -eq 0) {
			Write-Error "Error: no .cpp files found"
			return 1
		}

		if ($verbose) { Write-Host "Found $($source_files.Count) source files" }
		& $cpp_cmd $cpp_flags $source_files.FullName -o $output_name

		if ($LASTEXITCODE -ne 0) {
			Write-Error "Project compilation failed with exit code $LASTEXITCODE"
			return $LASTEXITCODE
		}
	}

	if (Test-Path "./$output_name.exe") {
		Write-Host "Executing..." -ForegroundColor Green
		if ($verbose) { Write-Host "Running with args: $args" }

		& "./$output_name.exe" $args
		$exit_code = $LASTEXITCODE

		# Clean up compiled files unless keep_compiled switch is used
		if (-not $keep_compiled) {
			Remove-Item "./$output_name.exe" -ErrorAction SilentlyContinue
		}

		return $exit_code
	} else {
		Write-Error "Error: Compilation produced no executable"
		return 1
	}
}

function run_java {
	<#
	.SYNOPSIS
		Compiles and runs Java programs
	.DESCRIPTION
		Compiles and runs Java programs with support for single file mode and project mode
	.PARAMETER single_file_mode
		If true, compiles and runs a specific file; otherwise runs in project mode
	.PARAMETER source_file
		Path to the Java file to compile in single file mode
	.PARAMETER args
		Arguments to pass to the Java program
	.PARAMETER keep_compiled
		If specified, does not remove compiled files after execution
	.PARAMETER java_verbose
		Show detailed compilation and execution information
	#>
	param (
		[Parameter(Position = 0)]
		[bool]$single_file_mode = $false,

		[Parameter(Position = 1)]
		[string]$source_file,

		[Parameter(Position = 2, ValueFromRemainingArguments)]
		[string[]]$args = @(),

		[switch]$keep_compiled,

		[switch]$verbose
	)

	# Set Java command based on version if specified
	$javac_cmd = "javac"
	$java_cmd = "java"

	if ($verbose) { Write-Host "Java compilation started at $(Get-Date)" -ForegroundColor Cyan }
	Write-Host "Compiling..." -ForegroundColor Yellow

	if ($single_file_mode) {
		if (Test-Path $source_file) {
			& $javac_cmd $source_file

			if ($LASTEXITCODE -ne 0) {
				Write-Error "Error: compilation failed with exit code $LASTEXITCODE"
				return $LASTEXITCODE
			}

			Write-Host "Executing..." -ForegroundColor Green
			$class_name = [System.IO.Path]::GetFileNameWithoutExtension($source_file)

			if ($verbose) { Write-Host "Running class: $class_name with args: $args" }
			& $java_cmd $class_name $args
			$exit_code = $LASTEXITCODE

			# Clean up compiled class files unless keep_compiled switch is used
			if (-not $keep_compiled) {
				Remove-Item "*.class" -ErrorAction SilentlyContinue
			}

			return $exit_code
		} else {
			Write-Error "Error: Source file \"$source_file\" not found"
			return 1
		}
	} else {
		# Project mode
		if (Test-Path "src/Main.java") {
			# Create output directory if it does not exist
			if (-not (Test-Path "out")) {
				New-Item -ItemType Directory -Path "out" -Force | Out-Null
			}

			# Find and compile all Java files
			$source_files = Get-ChildItem -Path "src" -Filter "*.java" -Recurse
			if ($verbose) { Write-Host "Found $($source_files.Count) source files" }

			& $javac_cmd -d out $source_files.FullName

			if ($LASTEXITCODE -ne 0) {
				Write-Error "Project compilation failed with exit code $LASTEXITCODE"
				return $LASTEXITCODE
			}

			# Copy assets if they exist
			if (Test-Path "src/assets") {
				if ($verbose) { Write-Host "Copying assets to output directory" }
				Copy-Item -Path "src/assets" -Destination "out" -Recurse -Force
			}

			Write-Host "Executing..." -ForegroundColor Green

			# Try to find the appropriate main class
			$main_class = "src.Main"
			if ($verbose) { Write-Host "Running main class: $main_class with args: $args" }

			& $java_cmd -cp out $main_class $args
			$exit_code = $LASTEXITCODE

			# Clean up compiled files unless keep_compiled switch is used
			if (-not $keep_compiled) {
				Remove-Item "out" -Recurse -Force
			}

			return $exit_code
		} else {
			Write-Error "Error: src/Main.java file not found"
			return 1
		}
	}
}

function run_scala {
	<#
	.SYNOPSIS
		Compiles and runs Scala programs
	.DESCRIPTION
		Compiles and runs Scala programs with support for single file mode and project mode
	.PARAMETER single_file_mode
		If true, compiles and runs a specific file; otherwise runs in project mode
	.PARAMETER source_file
		Path to the Scala file to compile in single file mode
	.PARAMETER args
		Arguments to pass to the Scala program
	.PARAMETER keep_compiled
		If specified, does not remove compiled files after execution
	.PARAMETER scala_verbose
		Show detailed compilation and execution information
	#>
	param (
		[Parameter(Position = 0)]
		[bool]$single_file_mode = $false,

		[Parameter(Position = 1)]
		[string]$source_file,

		[Parameter(Position = 2, ValueFromRemainingArguments)]
		[string[]]$args = @(),

		[switch]$keep_compiled,

		[switch]$verbose
	)

	# Set Scala commands
	$scala_cmd = "scala"
	$scalac_cmd = "scalac"

	if ($verbose) { Write-Host "Scala compilation started at $(Get-Date)" -ForegroundColor Cyan }

	if ($single_file_mode) {
		if (Test-Path $source_file) {
			Write-Host "Executing single file mode..." -ForegroundColor Green
			if ($verbose) { Write-Host "Running file: $source_file with args: $args" }

			& $scala_cmd $source_file $args
			return $LASTEXITCODE
		} else {
			Write-Error "Error: Source file '$source_file' not found"
			return 1
		}
	} else {
		# Project mode
		Write-Host "Compiling project..." -ForegroundColor Yellow

		if (Test-Path "Main.scala") {
			$source_files = Get-ChildItem -Filter "*.scala" -Recurse
			if ($verbose) { Write-Host "Found $($source_files.Count) source files" }

			# Create output directory if it doesn't exist
			if (-not (Test-Path "out")) {
				New-Item -ItemType Directory -Path "out" -Force | Out-Null
			}

			& $scalac_cmd -d out $source_files.FullName

			if ($LASTEXITCODE -ne 0) {
				Write-Error "Project compilation failed with exit code $LASTEXITCODE"
				return $LASTEXITCODE
			}

			Write-Host "Executing..." -ForegroundColor Green
			if ($verbose) { Write-Host "Running Main.scala with args: $args" }

			& $scala_cmd -classpath out Main $args
			$exit_code = $LASTEXITCODE

			# Clean up compiled files unless keep_compiled switch is used
			if (-not $keep_compiled) {
				Remove-Item "out" -Recurse -Force
			}

			return $exit_code
		} else {
			Write-Error "Error: Main.scala file not found"
			return 1
		}
	}
}

function ffe {
	$selected_file = $(fzf --preview "bat --style=numbers --color=always --line-range :500 {}")

	if ($selected_file) {
		nvim $selected_file
	}
}

function ff($name) {
	find -name $name
}
