################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../BSP/bsp.c \
../BSP/bsp_int.c \
../BSP/cpu_bsp.c 

C_DEPS += \
./BSP/bsp.d \
./BSP/bsp_int.d \
./BSP/cpu_bsp.d 

OBJS += \
./BSP/bsp.o \
./BSP/bsp_int.o \
./BSP/cpu_bsp.o 


# Each subdirectory must supply rules for building sources it contributes
BSP/%.o: ../BSP/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-A9 --no_unaligned_access -Dsoc_cv_av -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\APP" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\BSP" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\BSP\OS" -I"C:\intelFPGA\17.0\embedded\ip\altera\hps\altera_hps\hwlib\include" -I"C:\intelFPGA\17.0\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av" -I"C:\intelFPGA\17.0\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av\socal" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\HWLIBS" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\uC-CPU\ARM-Cortex-A" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\uC-CPU" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\uC-LIBS" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\uCOS-II\Ports" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\uCOS-II\Source" -I"C:\Users\rarog\ECE492\LaserHarpG6W18\software\LaserHarpG6W18\BSP\ARM_Compiler" --c99 --gnu -O0 -g --md --depend_format=unix_escaped --no_depend_system_headers --depend_dir="BSP" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


