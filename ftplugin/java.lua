local home = os.getenv("HOME")

local config = {
  cmd = { vim.fn.expand("~/.local/share/jdtls/bin/jdtls") },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),

  settings = {
    java = {
      home = home .. "/.local/share/mise/installs/java/temurin-24.0.1+9",
      eclise = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = home .. "/.local/share/mise/installs/java/temurin-11.0.27+6",
          },
          {
            name = "JavaSE-24",
            path = home .. ".local/share/mise/installs/java/temurin-24.0.1+9",
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
        preferred = "temurin-24.0.1+9",
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
