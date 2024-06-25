cmake_minimum_required(VERSION 3.3)
project(stm32-cmake-libopencm3)

set(INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/libopencm3/include)
set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/libopencm3/lib)

message(STATUS ${STM32_TARGET_SUBFAMILY})
message(STATUS ${STM32_TARGET_FAMILY})

SET(TARGET_CMAKE ${CMAKE_CURRENT_LIST_DIR}/targets/${STM32_TARGET_SUBFAMILY}.cmake)
if (NOT EXISTS ${TARGET_CMAKE})
    set(TARGET_CMAKE ${CMAKE_CURRENT_LIST_DIR}/targets/${STM32_TARGET_FAMILY}.cmake)
endif()
if (NOT EXISTS ${TARGET_CMAKE})
    message(FATAL_ERROR "Unknown target family ${STM32_TARGET_FAMILY} or subfamily ${STM32_TARGET_SUBFAMILY}")
endif()


include(${TARGET_CMAKE})

set(IRQ_FILE ${INCLUDE_DIR}/libopencm3/${TARGET_DIR}/irq.json)
set(GEN_NVIC_H ${INCLUDE_DIR}/libopencm3/${TARGET_DIR}/nvic.h)
set(GEN_VECTOR_NVIC_C ${SRC_DIR}/${TARGET_DIR}/vector_nvic.c)
set(GEN_IRQHANDLERS_H ${INCLUDE_DIR}/libopencmsis/${TARGET_DIR}/irqhandlers.h)

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

add_library(opencm3 STATIC ${TARGET_SRCS})
target_include_directories(opencm3 PUBLIC
    $<BUILD_INTERFACE:${INCLUDE_DIR}>
    $<INSTALL_INTERFACE:include>
)
add_dependencies(opencm3 gen_nvic)


set(CONFIG_FILE ${CMAKE_CURRENT_BINARY_DIR}/opencm3-config.cmake)
configure_file(cmake/opencm3-config.cmake ${CONFIG_FILE})
install(
    FILES ${CONFIG_FILE}
    DESTINATION ${STM32_CMAKE_CONFIG_PATH}
)

install(
    DIRECTORY ${INCLUDE_DIR}
    DESTINATION ${STM32_ROOT_PATH}/${STM32_MCU_NAME}
)

install(
    TARGETS opencm3
    LIBRARY DESTINATION ${STM32_LIB_PATH}
    ARCHIVE DESTINATION ${STM32_LIB_PATH}
)
