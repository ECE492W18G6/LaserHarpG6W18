--------------------------------------------------------------------------------------------------------------------------
-- Original Authors : Nancy Minderman											--
-- Date created: N/A 													--
--															--
-- This program was taken and edited from the ECE 492 Lab 1 Tutorial 1 in 2018.						--
--															--
-- Additional Authors : Adam Narten, Oliver Rarog, Randi Derbyshire, Celeste Chiasson					--
-- Date edited: January 26, 2018											--
--															--
-- This program is the toplevel file for the Quartus program to run on the DE1-SoC FPGA board. 			 	--
--------------------------------------------------------------------------------------------------------------------------

-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
	library ieee;
-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.


-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

	-- Basic sequential functions and concurrent procedures
	use ieee.VITAL_Primitives.all;


entity LaserHarpG6W18 is
	
	port
	(
	
			--Clock pin
			
			CLOCK_50					: in std_logic := 'X';
			
			
			-- HPS to DDR3 pins
			
			HPS_DDR3_ADDR 			: out std_logic_vector(14 downto 0);
			HPS_DDR3_BA 			: out std_logic_vector(2 downto 0);
			HPS_DDR3_CK_P 			: out std_logic;
			HPS_DDR3_CK_N 			: out std_logic;
			HPS_DDR3_CKE 			: out std_logic;
			HPS_DDR3_CS_N 			: out std_logic;
			HPS_DDR3_RAS_N 		: out std_logic;
			HPS_DDR3_CAS_N 		: out std_logic;
			HPS_DDR3_WE_N 			: out std_logic;
			HPS_DDR3_RESET_N 		: out std_logic;
			HPS_DDR3_DQ 			: inout std_logic_vector(31 downto 0) := (others => 'X');
			HPS_DDR3_DQS_P 		: inout std_logic_vector(3 downto 0) := (others => 'X');
			HPS_DDR3_DQS_N 		: inout std_logic_vector(3 downto 0) := (others => 'X');
			HPS_DDR3_ODT 			: out std_logic;
			HPS_DDR3_DM 			: out std_logic_vector(3 downto 0);
			HPS_DDR3_RZQ 			: in std_logic := 'X';
		
		
		-- HPS to Ethernet Pins
			
			HPS_ENET_RX_CLK 		: in std_logic := 'X';
			HPS_ENET_INT_N 		: inout std_logic := 'X';
			HPS_ENET_MDC 			: out std_logic;
			HPS_ENET_MDIO 			: inout std_logic := 'X';
			HPS_ENET_RX_DATA_0 	: in std_logic := 'X';
			HPS_ENET_RX_DATA_1 	: in std_logic := 'X';
			HPS_ENET_RX_DATA_2 	: in std_logic := 'X';
			HPS_ENET_RX_DATA_3 	: in std_logic := 'X';
			HPS_ENET_RX_DV 		: in std_logic := 'X';
			HPS_ENET_GTX_CLK 		: out std_logic;
			HPS_ENET_TX_DATA_0 	: out std_logic;
			HPS_ENET_TX_DATA_1 	: out std_logic;
			HPS_ENET_TX_DATA_2 	: out std_logic;
			HPS_ENET_TX_DATA_3 	: out std_logic;
			HPS_ENET_TX_EN 		: out std_logic;

			
			-- HPS to SD Card pins

			HPS_SD_CLK 				: out std_logic;
			HPS_SD_CMD 				: inout std_logic := 'X';
			HPS_SD_DATA_0 			: inout std_logic := 'X';
			HPS_SD_DATA_1 			: inout std_logic := 'X';
			HPS_SD_DATA_2 			: inout std_logic := 'X';
			HPS_SD_DATA_3 			: inout std_logic := 'X';
		
		
		-- USB pins
		
			HPS_USB_CLKOUT 		: in std_logic := 'X';
			HPS_USB_DATA_0 		: inout std_logic := 'X';
			HPS_USB_DATA_1 		: inout std_logic := 'X';
			HPS_USB_DATA_2 		: inout std_logic := 'X';
			HPS_USB_DATA_3 		: inout std_logic := 'X';
			HPS_USB_DATA_4 		: inout std_logic := 'X';
			HPS_USB_DATA_5 		: inout std_logic := 'X';
			HPS_USB_DATA_6 		: inout std_logic := 'X';
			HPS_USB_DATA_7 		: inout std_logic := 'X';
			HPS_USB_DIR 			: in std_logic := 'X';
			HPS_USB_NXT 			: in std_logic := 'X';
			HPS_USB_STP 			: out std_logic;
		
		
		-- SPI pins
		
			HPS_SPIM_CLK 			: out std_logic;
			HPS_SPIM_MISO 			: in std_logic := 'X';
			HPS_SPIM_MOSI 			: out std_logic;
			HPS_SPIM_SS 			: out std_logic; 

			
		-- Uart to USB pins
			
			HPS_UART_RX 			: in std_logic := 'X';
			HPS_UART_TX 			: out std_logic;
			HPS_CONV_USB_N 		: inout std_logic := 'X';

			
		-- I2C pins
			
			HPS_I2C1_SCLK 			: inout std_logic := 'X';
			HPS_I2C1_SDAT 			: inout std_logic := 'X';
			HPS_I2C2_SCLK 			: inout std_logic := 'X';
			HPS_I2C2_SDAT 			: inout std_logic := 'X';
			HPS_I2C_CONTROL 		: inout std_logic := 'X';

			
		-- All other HPS pins
			
			HPS_KEY_N 				: inout std_logic := 'X';
			HPS_LED 					: inout std_logic := 'X';
			HPS_LTC_GPIO 			: inout std_logic := 'X';
			HPS_GSENSOR_INT 		: inout std_logic := 'X';
		
		
		-- LCD Display
			GPIO_0					: inout std_logic_vector(7 downto 0);
			GPIO_0_8					: out std_logic;
			GPIO_0_9					: out std_logic;
			GPIO_0_10				: out std_logic;
			
			
		-- Switches
			SW							: in std_logic_vector(9 downto 0);
		
		
		-- FPGA side pins
			
			LEDR 						: out std_logic_vector(9 downto 0);
			KEY_N						: in std_logic_vector(3 downto 0);
			
		-- I2C Interface
			FPGA_I2C_SCLK			: out std_logic;
			FPGA_I2C_SDAT			: inout std_logic := 'X';
			
		-- Audio
			AUD_ADCDAT				: in std_logic := 'X';
			AUD_ADCLRCK				: in std_logic := 'X';
			AUD_BCLK					: in std_logic := 'X';
			AUD_DACDAT				: out std_logic;
			AUD_DACLRCK				: in std_logic := 'X';
			AUD_XCK					: out std_logic;	
			
		-- Photodiode pins
			GPIO_0_28				: in std_logic
	);
end LaserHarpG6W18;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture rtl of LaserHarpG6W18 is

	-- Declarations (optional)
	 component soc_system is
        port (
            audio_0_external_interface_ADCDAT                : in    std_logic                     := 'X';             -- ADCDAT
            audio_0_external_interface_ADCLRCK               : in    std_logic                     := 'X';             -- ADCLRCK
            audio_0_external_interface_BCLK                  : in    std_logic                     := 'X';             -- BCLK
            audio_0_external_interface_DACDAT                : out   std_logic;                                        -- DACDAT
            audio_0_external_interface_DACLRCK               : in    std_logic                     := 'X';             -- DACLRCK
            audio_and_video_config_0_external_interface_SDAT : inout std_logic                     := 'X';             -- SDAT
            audio_and_video_config_0_external_interface_SCLK : out   std_logic;                                        -- SCLK
            button_0_external_connection_export              : in    std_logic                     := 'X';             -- export
            button_1_external_connection_export              : in    std_logic                     := 'X';             -- export
            button_2_external_connection_export              : in    std_logic                     := 'X';             -- export
            button_3_external_connection_export              : in    std_logic                     := 'X';             -- export
            character_lcd_0_external_interface_DATA          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- DATA
            character_lcd_0_external_interface_ON            : out   std_logic;                                        -- ON
            character_lcd_0_external_interface_BLON          : out   std_logic;                                        -- BLON
            character_lcd_0_external_interface_EN            : out   std_logic;                                        -- EN
            character_lcd_0_external_interface_RS            : out   std_logic;                                        -- RS
            character_lcd_0_external_interface_RW            : out   std_logic;                                        -- RW
            clk_clk                                          : in    std_logic                     := 'X';             -- clk
            hps_io_hps_io_emac1_inst_TX_CLK                  : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0                    : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1                    : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2                    : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3                    : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0                    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO                    : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC                     : out   std_logic;                                        -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL                  : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL                  : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK                  : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1                    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2                    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3                    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD                      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0                       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1                       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK                      : out   std_logic;                                        -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2                       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3                       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7                       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK                      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP                      : out   std_logic;                                        -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR                      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT                      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK                     : out   std_logic;                                        -- hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI                    : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO                    : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0                     : out   std_logic;                                        -- hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX                      : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX                      : out   std_logic;                                        -- hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA                      : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL                      : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA                      : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL                      : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO09                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO35                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO40                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
            hps_io_hps_io_gpio_inst_GPIO48                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
            hps_io_hps_io_gpio_inst_GPIO53                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
            hps_io_hps_io_gpio_inst_GPIO61                   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
            memory_mem_a                                     : out   std_logic_vector(14 downto 0);                    -- mem_a
            memory_mem_ba                                    : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck                                    : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n                                  : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke                                   : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n                                  : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n                                 : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n                                 : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n                                  : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n                               : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq                                    : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs                                   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n                                 : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt                                   : out   std_logic;                                        -- mem_odt
            memory_mem_dm                                    : out   std_logic_vector(3 downto 0);                     -- mem_dm
            memory_oct_rzqin                                 : in    std_logic                     := 'X';             -- oct_rzqin
            red_leds_external_connection_export              : out   std_logic_vector(9 downto 0);                     -- export
            reset_reset_n                                    : in    std_logic                     := 'X';             -- reset_n
            switches_external_connection_export              : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
            pll_0_outclk0_clk                                : out   std_logic;                             -- clk
				photodiode_0_conduit_end_export						 : in 	std_logic
        );
    end component soc_system;

begin

	-- Process Statement (optional)

	-- Concurrent Procedure Call (optional)

	-- Concurrent Signal Assignment (optional)

	-- Conditional Signal Assignment (optional)

	-- Selected Signal Assignment (optional)

	-- Component Instantiation Statement (optional)
	  u0 : component soc_system
        port map (
						clk_clk 										=> CLOCK_50,
						reset_reset_n 								=> KEY_N(0),
						memory_mem_a 								=> HPS_DDR3_ADDR,
						memory_mem_ba 								=> HPS_DDR3_BA,
						memory_mem_ck 								=> HPS_DDR3_CK_P,
						memory_mem_ck_n 							=> HPS_DDR3_CK_N,
						memory_mem_cke 							=> HPS_DDR3_CKE,
						memory_mem_cs_n 							=> HPS_DDR3_CS_N,
						memory_mem_ras_n 							=> HPS_DDR3_RAS_N,
						memory_mem_cas_n 							=> HPS_DDR3_CAS_N,
						memory_mem_we_n 							=> HPS_DDR3_WE_N,
						memory_mem_reset_n 						=> HPS_DDR3_RESET_N,
						memory_mem_dq 								=> HPS_DDR3_DQ,
						memory_mem_dqs 							=> HPS_DDR3_DQS_P,
						memory_mem_dqs_n 							=> HPS_DDR3_DQS_N,
						memory_mem_odt 							=> HPS_DDR3_ODT,
						memory_mem_dm 								=> HPS_DDR3_DM,
						memory_oct_rzqin							=> HPS_DDR3_RZQ,
						hps_io_hps_io_emac1_inst_TX_CLK 		=> HPS_ENET_GTX_CLK,
						hps_io_hps_io_emac1_inst_TXD0 		=> HPS_ENET_TX_DATA_0,
						hps_io_hps_io_emac1_inst_TXD1 		=> HPS_ENET_TX_DATA_1, 
						hps_io_hps_io_emac1_inst_TXD2 		=> HPS_ENET_TX_DATA_2,
						hps_io_hps_io_emac1_inst_TXD3 		=> HPS_ENET_TX_DATA_3,
						hps_io_hps_io_emac1_inst_RXD0 		=> HPS_ENET_RX_DATA_0,
						hps_io_hps_io_emac1_inst_MDIO 		=> HPS_ENET_MDIO,
						hps_io_hps_io_emac1_inst_MDC 			=> HPS_ENET_MDC,
						hps_io_hps_io_emac1_inst_RX_CTL		=> HPS_ENET_RX_DV,
						hps_io_hps_io_emac1_inst_TX_CTL 		=> HPS_ENET_TX_EN,
						hps_io_hps_io_emac1_inst_RX_CLK 		=> HPS_ENET_RX_CLK,
						hps_io_hps_io_emac1_inst_RXD1 		=> HPS_ENET_RX_DATA_1,
						hps_io_hps_io_emac1_inst_RXD2 		=> HPS_ENET_RX_DATA_2,
						hps_io_hps_io_emac1_inst_RXD3 		=> HPS_ENET_RX_DATA_3,
						hps_io_hps_io_sdio_inst_CMD 			=> HPS_SD_CMD,
						hps_io_hps_io_sdio_inst_D0 			=> HPS_SD_DATA_0,
						hps_io_hps_io_sdio_inst_D1 			=> HPS_SD_DATA_1,
						hps_io_hps_io_sdio_inst_CLK 			=> HPS_SD_CLK,
						hps_io_hps_io_sdio_inst_D2 			=> HPS_SD_DATA_2,
						hps_io_hps_io_sdio_inst_D3 			=> HPS_SD_DATA_3,
						hps_io_hps_io_usb1_inst_D0 			=> HPS_USB_DATA_0,
						hps_io_hps_io_usb1_inst_D1				=> HPS_USB_DATA_1,
						hps_io_hps_io_usb1_inst_D2 			=> HPS_USB_DATA_2,
						hps_io_hps_io_usb1_inst_D3 			=> HPS_USB_DATA_3,
						hps_io_hps_io_usb1_inst_D4 			=> HPS_USB_DATA_4,
						hps_io_hps_io_usb1_inst_D5 			=> HPS_USB_DATA_5,
						hps_io_hps_io_usb1_inst_D6 			=> HPS_USB_DATA_6,
						hps_io_hps_io_usb1_inst_D7 			=> HPS_USB_DATA_7,
						hps_io_hps_io_usb1_inst_CLK 			=> HPS_USB_CLKOUT,
						hps_io_hps_io_usb1_inst_STP 			=> HPS_USB_STP,
						hps_io_hps_io_usb1_inst_DIR 			=> HPS_USB_DIR,
						hps_io_hps_io_usb1_inst_NXT 			=> HPS_USB_NXT,
						hps_io_hps_io_spim1_inst_CLK 			=> HPS_SPIM_CLK,
						hps_io_hps_io_spim1_inst_MOSI 		=> HPS_SPIM_MOSI,
						hps_io_hps_io_spim1_inst_MISO 		=> HPS_SPIM_MISO,
						hps_io_hps_io_spim1_inst_SS0 			=> HPS_SPIM_SS,
						hps_io_hps_io_uart0_inst_RX 			=> HPS_UART_RX,
						hps_io_hps_io_uart0_inst_TX 			=> HPS_UART_TX,
						hps_io_hps_io_i2c0_inst_SDA 			=> HPS_I2C1_SDAT,
						hps_io_hps_io_i2c0_inst_SCL 			=> HPS_I2C1_SCLK,
						hps_io_hps_io_i2c1_inst_SDA 			=> HPS_I2C2_SDAT,
						hps_io_hps_io_i2c1_inst_SCL 			=> HPS_I2C2_SCLK,
						hps_io_hps_io_gpio_inst_GPIO09 		=> HPS_CONV_USB_N,
						hps_io_hps_io_gpio_inst_GPIO35 		=> HPS_ENET_INT_N,
						hps_io_hps_io_gpio_inst_GPIO40 		=> HPS_LTC_GPIO,
						hps_io_hps_io_gpio_inst_GPIO48 		=> HPS_I2C_CONTROL,
						hps_io_hps_io_gpio_inst_GPIO53 		=> HPS_LED,
						hps_io_hps_io_gpio_inst_GPIO54 		=> HPS_KEY_N,
						hps_io_hps_io_gpio_inst_GPIO61 		=> HPS_GSENSOR_INT,
						character_lcd_0_external_interface_DATA => GPIO_0,
						character_lcd_0_external_interface_EN   => GPIO_0_9,
						character_lcd_0_external_interface_RS   => GPIO_0_8,
						character_lcd_0_external_interface_RW   => GPIO_0_10,	
						switches_external_connection_export	=> SW,
						audio_and_video_config_0_external_interface_SDAT => FPGA_I2C_SDAT, -- audio_and_video_config_0_external_interface.SDAT
						audio_and_video_config_0_external_interface_SCLK => FPGA_I2C_SCLK, --                                            .SCLK
						audio_0_external_interface_ADCDAT                => AUD_ADCDAT,                --                  audio_0_external_interface.ADCDAT
						audio_0_external_interface_ADCLRCK               => AUD_ADCLRCK,               --                                            .ADCLRCK
						audio_0_external_interface_BCLK                  => AUD_BCLK,                  --                                            .BCLK
						audio_0_external_interface_DACDAT                => AUD_DACDAT,                --                                            .DACDAT
						audio_0_external_interface_DACLRCK               => AUD_DACLRCK,                --                                            .DACLRCK
						pll_0_outclk0_clk				=> AUD_XCK,
						button_0_external_connection_export => KEY_N(0),
						button_1_external_connection_export => KEY_N(1),
						button_2_external_connection_export => KEY_N(2),
						button_3_external_connection_export => KEY_N(3),
						red_leds_external_connection_export => LEDR,
						photodiode_0_conduit_end_export => GPIO_0_28
        );


	-- Generate Statement (optional)

end rtl;

