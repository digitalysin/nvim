local home = os.getenv("HOME")

local config = {
  cmd = { vim.fn.expand("~/.local/share/jdtls/bin/jdtls") },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),

  settings = {
    java = {
      home = home .. "/.local/share/mise/installs/java/temurin-23.0.2+7",
      eclise = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = home .. "/.local/share/mise/installs/java/corretto-8.442.06.1",
          },
          {
            name = "JavaSE-11",
            path = home .. "/.local/share/mise/installs/java/temurin-11.0.25+9",
          },
          {
            name = "JavaSE-21",
            path = home .. "/.local/share/mise/installs/java/temurin-21.0.6+7.0.LTS",
          },
          {
            name = "JavaSE-22",
            path = home .. "/.local/share/mise/installs/java/temurin-22.0.1+8"
          },
          {
            name = "JavaSE-23",
            path = home .. "/.local/share/mise/installs/java/temurin-23.0.2+7",
            default = true,
          },
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
        updateIndexes = true,
      },
      implementation = {
        preferred = "temurin-23.0.2+7",
      },
      implementationCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = home .. "/.local/share/jdtls/formatter.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = {
        enabled = true,
      },
    },
  },
}

local bundles = {
  vim.fn.glob(home .. "/.local/share/jdtls/com.microsoft.java.debug.plugin-*.jar"),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/jdtls/vs-code-test/*.jar", 1), "\n"))

config["init_options"] = {
  bundles = bundles,
}

require("jdtls").start_or_attach(config)
