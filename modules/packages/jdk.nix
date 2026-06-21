{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		javaPackages.compiler.temurin-bin.jdk-26
		# javaPackages.compiler.temurin-bin.jdk-25
		# javaPackages.compiler.temurin-bin.jdk-21
		# javaPackages.compiler.temurin-bin.jdk-17
		# javaPackages.compiler.temurin-bin.jdk-8
	];
}
