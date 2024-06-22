cmake_minimum_required(VERSION 3.3)
project(stm32-cmake-libopencm3)

# Sets TARGETS to:
#   stm32/f0 stm32/f1 ... sam/3a sam/3n ... vf6xx swm050 pac55xx
# ie: Specific directories under lib

# Gets a list of IRQ definition files from include/libopencm3/target/irq.json

# Defines a list of nvic.h/nvic.c/irqhandlers.h for each target.
# These files to not exist, they are generated using the scripts/irq2nvic_h script
# These files are all collected under the IRQ_GENERATED_FILES target

# lib depends on LIB_DIRS
# LIB_DIRS target depends on IRQ_GENERATED_FILES
# The LIB_DIRS target calls the makefile under the lib directory

# Example: look at lib/stm32/f1/Makefile
# Sets up flags, etc

# Defines the source files the following way:
# - Defines list of object files, without any directory
# - Appends to VPATH, which defines where make will look for the source files
# - OBJS added as dependency to library file, and there is a rule for %.o
#   that depends on %.c, so gets the corresponding source file
# - In all cases, include directory is the same
# - At the end, inclues a common makefile, that defines the above rules
#   and adds some common object files (but doesn't add to VPATH)

set(INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/libopencm3/include)
set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/libopencm3/lib)

set(IRQ_FILE ${INCLUDE_DIR}/libopencm3/stm32/f1/irq.json)
set(GEN_DIR ${CMAKE_BINARY_DIR}/gen)
set(GEN_NVIC_H ${INCLUDE_DIR}/libopencm3/stm32/f1/nvic.h)
set(GEN_VECTOR_NVIC_C ${SRC_DIR}/stm32/f1/vector_nvic.c)
set(GEN_IRQHANDLERS_H ${INCLUDE_DIR}/libopencmsis/stm32/f1/irqhandlers.h)

add_custom_command(
    OUTPUT
        ${GEN_NVIC_H}
        ${GEN_VECTOR_NVIC_C}
        ${GEN_IRQHANDLERS_H}
    COMMAND
        python3
        ${CMAKE_CURRENT_LIST_DIR}/scripts/irq2nvic_h.py
        ${IRQ_FILE}
        ${GEN_NVIC_H}
        ${GEN_VECTOR_NVIC_C}
        ${GEN_IRQHANDLERS_H}
    COMMENT "Generating nvic headers and source file"
)
add_custom_target(gen_nvic ALL DEPENDS
    ${GEN_NVIC_H}
    ${GEN_VECTOR_NVIC_C}
    ${GEN_IRQHANDLERS_H}
)

add_library(opencm3 STATIC
    ${SRC_DIR}/cm3/vector.c
    ${SRC_DIR}/cm3/systick.c
    ${SRC_DIR}/cm3/scb.c
    ${SRC_DIR}/cm3/nvic.c
    ${SRC_DIR}/cm3/assert.c
    ${SRC_DIR}/cm3/sync.c
    ${SRC_DIR}/cm3/dwt.c

    ${SRC_DIR}/stm32/f1/adc.c
    ${SRC_DIR}/stm32/common/adc_common_v1.c

    ${SRC_DIR}/stm32/can.c

    ${SRC_DIR}/stm32/common/crc_common_all.c
    ${SRC_DIR}/stm32/common/desig_common_all.c
    ${SRC_DIR}/stm32/common/desig_common_v1.c
    ${SRC_DIR}/stm32/common/dma_common_l1f013.c
    ${SRC_DIR}/stm32/common/exti_common_all.c

    ${SRC_DIR}/stm32/f1/flash.c
    ${SRC_DIR}/stm32/common/flash_common_all.c
    ${SRC_DIR}/stm32/common/flash_common_f.c
    ${SRC_DIR}/stm32/common/flash_common_f01.c

    ${SRC_DIR}/stm32/f1/gpio.c
    ${SRC_DIR}/stm32/common/gpio_common_all.c

    ${SRC_DIR}/stm32/common/i2c_common_v1.c
    ${SRC_DIR}/stm32/common/iwdg_common_all.c
    ${SRC_DIR}/stm32/common/pwr_common_v1.c
    ${SRC_DIR}/stm32/f1/rcc.c
    ${SRC_DIR}/stm32/common/rcc_common_all.c

    ${SRC_DIR}/stm32/f1/rtc.c

    ${SRC_DIR}/stm32/common/spi_common_all.c
    ${SRC_DIR}/stm32/common/spi_common_v1.c

    ${SRC_DIR}/stm32/f1/timer.c
    ${SRC_DIR}/stm32/common/timer_common_all.c

    ${SRC_DIR}/stm32/common/usart_common_all.c
    ${SRC_DIR}/stm32/common/usart_common_f124.c

    ${SRC_DIR}/ethernet/mac.c
    ${SRC_DIR}/ethernet/mac_stm32fxx7.c
    ${SRC_DIR}/ethernet/phy.c
    ${SRC_DIR}/ethernet/phy_ksz80x1.c

    ${SRC_DIR}/usb/usb.c
    ${SRC_DIR}/usb/usb_control.c
    ${SRC_DIR}/usb/usb_standard.c
    ${SRC_DIR}/usb/usb_msc.c
    ${SRC_DIR}/usb/usb_hid.c
    ${SRC_DIR}/usb/usb_audio.c
    ${SRC_DIR}/usb/usb_cdc.c
    ${SRC_DIR}/usb/usb_midi.c
    ${SRC_DIR}/usb/usb_dwc_common.c
    ${SRC_DIR}/usb/usb_f107.c
    ${SRC_DIR}/stm32/common/st_usbfs_core.c
    ${SRC_DIR}/stm32/st_usbfs_v1.c
)
target_include_directories(opencm3 PUBLIC
    ${INCLUDE_DIR}
    ${GEN_DIR}/include
)
add_dependencies(opencm3 gen_nvic)
