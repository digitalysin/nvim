# NVIM for golang, java

## Requirements
* mise   (master)
* golang (1.24)
* java   (24)
* nodejs (v24.1.0)

## Optional
* dotnet

make sure you have installed mise, golang, java, nodejs

## Other dependencies for debugging and LSP
* delve for debugging golang application
* jdtls for LSP [here](https://download.eclipse.org/jdtls/snapshots/?d) right now using version jdt-language-server-1.34.0-202404031240.tar.gz
* java-debug for debugging java test [here](https://github.com/microsoft/java-debug)
* vscode-java-test for debugging java application [here](https://github.com/microsoft/vscode-java-test)

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
* run `npm run build-plugin`
* run `cp server/*.jar ~/.local/share/jdtls/`

## For dotnet development
you can install using mason
