#ifndef __VIRT_CFG__H__
#define __VIRT_CFG__H__

#define PAGE_SIZE   (0x2000)        /* 4KB */

#define ROM_BASE    (0x00000000)
#define ROM_SIZE    (0x08000000)    /* 128MB */
#define ROM_LIMIT   ((ROM_BASE) + (ROM_SIZE))

#define SRAM_BASE   (0x0e000000)
#define SRAM_SIZE   (0x01000000)    /* 16MB */
#define SRAM_LIMIT  ((SRAM_BASE) + (SRAM_SIZE))

#define DRAM_BASE   (0x40000000)
#define DRAM_SIZE   (0x40000000)    /* 1GB */
#define DRAM_LIMIT  ((DRAM_BASE) + (DRAM_SIZE))

#define LOAD_BASE   ROM_BASE
#define LOAD_SIZE   ROM_SIZE
#define LOAD_LIMIT  ((ROM_BASE) + (ROM_SIZE))

#define BL_RO_BASE  LOAD_BASE
#define BL_RO_SIZE  LOAD_SIZE
#define BL_RO_LIMIT LOAD_LIMIT

#define BL_RW_SIZE  (0x12000)       /* 72KB */
#define BL_RW_BASE  ((BL_RW_LIMIT) - (BL_RW_SIZE))
#define BL_RW_LIMIT ((SRAM_BASE) + (SRAM_SIZE))

#endif  /* !__VIRT_CFG__H__ */
