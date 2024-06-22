set(TARGET_DIR stm32/f1)

set(TARGET_SRCS
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
