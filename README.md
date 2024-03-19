# NVIM for golang, java and elixir


## Requirements
* asdf
* golang
* elixir
* java

make sure you have installed golang, java21 and latest elixir and erlang

## Other dependencies for debugging and LSP
* delve for debugging golang application
* jdtls for LSP [here](https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-1.34.0-202403060309.tar.gz)
* vscode-java-test for debugging java test [here](https://github.com/microsoft/vscode-java-test)
* java-debug for debugging java application [here](https://github.com/microsoft/vscode-java-test)


## For java development

* create directory in `~/.local/share/jdtls` and put `jdtls.jar` into that directory
* put any `*.jar` generated from java-debug
* put any `*.jar` generated from vscode-java-test

## For dotnet development

To develop dotnet application, you need to setup and download `omnisharp rosyln` server manually
from [here](https://github.com/OmniSharp/omnisharp-roslyn/releases) and then follow these step:

* Extract downloaded omnisharp server to "$HOME/.local/share/omnisharp"
