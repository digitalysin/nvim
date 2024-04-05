# NVIM for golang, java and elixir


## Requirements
* asdf   (master)
* golang (1.22.1)
* erlang (otp-26)
* elixir (1.16)
* java   (21)
* dotnet (v8)
* nodejs (v20.11.1)

make sure you have installed asdf, golang, erlang, elixir, java, dotnet and nodejs

## Other dependencies for debugging and LSP
* delve for debugging golang application
* jdtls for LSP [here](https://download.eclipse.org/jdtls/snapshots/?d) right now using version jdt-language-server-1.34.0-202404031240.tar.gz
* vscode-java-test for debugging java test [here](https://github.com/microsoft/java-debug)
* java-debug for debugging java application [here](https://github.com/microsoft/vscode-java-test)


## For java development
first you have to compile and build `java-debug` and `vscode-java-test` jar files manually

### JDTLS
* download latest version of JDTLS
* extract to `~/.local/share/jdtls`

### Java Debug
* clone repository and change directory to java-debug
* run command 
```sh 
./mvnw clean install
```
* copy files from com.microsoft.java.debug.plugin/target/*.jar to ~/.local/share/jdtls directory
```sh
cp com.microsoft.java.debug.plugin/target/*.jar ~/.local/share/jdtls/
```

### VsCode Java Test
* clone repository and cd to `vscode-java-test`
* make sure nodejs installed
* make sure to use java 21 (right now this one is supported, latest version of java 22 is not supported yet)
* run `npm install`
* run `nom run build-plugin`
* run `cp server/*.jar ~/.local/share/jdtls/`

## For DotNet development

To develop dotnet application, you need to setup and download `omnisharp rosyln` server manually
from [here](https://github.com/OmniSharp/omnisharp-roslyn/releases) and then follow these step:

* Extract downloaded omnisharp server to "$HOME/.local/share/omnisharp"
