local home = os.getenv("HOME")

local config = {
	cmd = { vim.fn.expand("~/.local/share/jdtls/bin/jdtls") },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),

	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-1.8",
						path = home .. "/.asdf/installs/java/corretto-8.362.08.1", -- for compability between macos and linux
					},
					{
						name = "JavaSE-11",
						path = home .. "/.asdf/installs/java/adoptopenjdk-11.0.21+9",
					},
					{
						name = "JavaSE-17",
						path = home .. "/.asdf/installs/java/adoptopenjdk-17.0.10+7",
					},
					{
						name = "JavaSE-20",
						path = home .. "/.asdf/installs/java/adoptopenjdk-20.0.2+9",
					},
					{
						name = "JavaSE-21",
						path = home .. "/.asdf/installs/java/adoptopenjdk-21.0.2+13.0.LTS",
						default = true,
					},
					{
						name = "JavaSE-22",
						path = home .. "/.asdf/installs/java/openjdk-22", -- later will update to use adoptopenjdk version
					},
				},
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
