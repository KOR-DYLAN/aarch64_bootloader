-include .config
include $(scriptdir)/Makefile.toolchain
include $(scriptdir)/Makefile.arch
include $(scriptdir)/Makefile.warning
include $(scriptdir)/Makefile.feature
include $(scriptdir)/Makefile.optimize
include $(objects)

ldflags := $(addprefix -Wl,$(ldflags-y))
arflags := rcs

all: $(target)

$(builddir)/%.elf: $(obj) $(lds)
ifeq ($(lds),)
	@printf "%-10s $@\n" "[LD]"
	$(Q)$(CC) $(ldflags) -Wl,-Map=$(basename $@).map -o $@ $(obj)
else
	@printf "%-10s $@\n" "[LD]"
	$(Q)$(LD) $(ldflags) -z noexecstack --gc-sections --fatal-warnings -Map=$(basename $@).map --script $(lds) -o $@ $(obj)
	$(Q)$(SZ) $@
endif

ifeq ($(CONFIG_EXPORT_ASM),y)
	@printf "%-10s $(basename $@).asm\n" "[OD]"
	$(Q)$(OD) -d $@ > $(basename $@).asm
endif

ifeq ($(CONFIG_EXPORT_BIN),y)
	@printf "%-10s $(basename $@).bin\n" "[OC]"
	$(Q)$(OC) -O binary $@ $(basename $@).bin
endif

$(builddir)/%.a: $(obj)
	@printf "%-10s $@\n" "[AR]"
	$(Q)$(AR) $(arflags) -o $@ $(obj)

.PHONY += $(target)
