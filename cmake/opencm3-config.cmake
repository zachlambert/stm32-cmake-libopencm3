add_library(opencm3 STATIC IMPORTED)
set_target_properties(opencm3 PROPERTIES IMPORTED_LOCATION ${STM32_LIB_PATH}/libopencm3.a)
target_include_directories(opencm3 INTERFACE ${STM32_INCLUDE_PATH})
