{
	boot.kernel.sysfs = {
		kernel.mm.transparent_hugepage = {
			enabled = "madvise";
			defrag = "defer";
			shmem_enabled = "advise";
			khugepaged.defrag = "1";
		};
	};
}
