# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "D:\\sources\\2026\\GoldenBell1B\\iic_test\\ws\\gb1b\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\sleep.h"
  "D:\\sources\\2026\\GoldenBell1B\\iic_test\\ws\\gb1b\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\xiltimer.h"
  "D:\\sources\\2026\\GoldenBell1B\\iic_test\\ws\\gb1b\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\xtimer_config.h"
  "D:\\sources\\2026\\GoldenBell1B\\iic_test\\ws\\gb1b\\microblaze_0\\standalone_microblaze_0\\bsp\\lib\\libxiltimer.a"
  )
endif()
