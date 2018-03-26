	component soc_system is
		port (
			audio_0_external_interface_ADCDAT                : in    std_logic                     := 'X';             -- ADCDAT
			audio_0_external_interface_ADCLRCK               : in    std_logic                     := 'X';             -- ADCLRCK
			audio_0_external_interface_BCLK                  : in    std_logic                     := 'X';             -- BCLK
			audio_0_external_interface_DACDAT                : out   std_logic;                                        -- DACDAT
			audio_0_external_interface_DACLRCK               : in    std_logic                     := 'X';             -- DACLRCK
			audio_and_video_config_0_external_interface_SDAT : inout std_logic                     := 'X';             -- SDAT
			audio_and_video_config_0_external_interface_SCLK : out   std_logic;                                        -- SCLK
			buttons_external_connection_export               : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
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
			photodiode_0_conduit_end_export0                 : in    std_logic                     := 'X';             -- export0
			photodiode_0_conduit_end_export1                 : in    std_logic                     := 'X';             -- export1
			photodiode_0_conduit_end_export2                 : in    std_logic                     := 'X';             -- export2
			photodiode_0_conduit_end_export3                 : in    std_logic                     := 'X';             -- export3
			photodiode_0_conduit_end_export4                 : in    std_logic                     := 'X';             -- export4
			photodiode_0_conduit_end_export5                 : in    std_logic                     := 'X';             -- export5
			photodiode_0_conduit_end_export6                 : in    std_logic                     := 'X';             -- export6
			photodiode_0_conduit_end_export7                 : in    std_logic                     := 'X';             -- export7
			pll_0_outclk0_clk                                : out   std_logic;                                        -- clk
			red_leds_external_connection_export              : out   std_logic_vector(9 downto 0);                     -- export
			reset_reset_n                                    : in    std_logic                     := 'X';             -- reset_n
			switches_external_connection_export              : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			audio_0_external_interface_ADCDAT                => CONNECTED_TO_audio_0_external_interface_ADCDAT,                --                  audio_0_external_interface.ADCDAT
			audio_0_external_interface_ADCLRCK               => CONNECTED_TO_audio_0_external_interface_ADCLRCK,               --                                            .ADCLRCK
			audio_0_external_interface_BCLK                  => CONNECTED_TO_audio_0_external_interface_BCLK,                  --                                            .BCLK
			audio_0_external_interface_DACDAT                => CONNECTED_TO_audio_0_external_interface_DACDAT,                --                                            .DACDAT
			audio_0_external_interface_DACLRCK               => CONNECTED_TO_audio_0_external_interface_DACLRCK,               --                                            .DACLRCK
			audio_and_video_config_0_external_interface_SDAT => CONNECTED_TO_audio_and_video_config_0_external_interface_SDAT, -- audio_and_video_config_0_external_interface.SDAT
			audio_and_video_config_0_external_interface_SCLK => CONNECTED_TO_audio_and_video_config_0_external_interface_SCLK, --                                            .SCLK
			buttons_external_connection_export               => CONNECTED_TO_buttons_external_connection_export,               --                 buttons_external_connection.export
			character_lcd_0_external_interface_DATA          => CONNECTED_TO_character_lcd_0_external_interface_DATA,          --          character_lcd_0_external_interface.DATA
			character_lcd_0_external_interface_ON            => CONNECTED_TO_character_lcd_0_external_interface_ON,            --                                            .ON
			character_lcd_0_external_interface_BLON          => CONNECTED_TO_character_lcd_0_external_interface_BLON,          --                                            .BLON
			character_lcd_0_external_interface_EN            => CONNECTED_TO_character_lcd_0_external_interface_EN,            --                                            .EN
			character_lcd_0_external_interface_RS            => CONNECTED_TO_character_lcd_0_external_interface_RS,            --                                            .RS
			character_lcd_0_external_interface_RW            => CONNECTED_TO_character_lcd_0_external_interface_RW,            --                                            .RW
			clk_clk                                          => CONNECTED_TO_clk_clk,                                          --                                         clk.clk
			hps_io_hps_io_emac1_inst_TX_CLK                  => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CLK,                  --                                      hps_io.hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD0,                    --                                            .hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD1,                    --                                            .hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD2,                    --                                            .hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD3,                    --                                            .hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD0,                    --                                            .hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDIO,                    --                                            .hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC                     => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDC,                     --                                            .hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL                  => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CTL,                  --                                            .hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL                  => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CTL,                  --                                            .hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK                  => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CLK,                  --                                            .hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD1,                    --                                            .hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD2,                    --                                            .hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3                    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD3,                    --                                            .hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD                      => CONNECTED_TO_hps_io_hps_io_sdio_inst_CMD,                      --                                            .hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0                       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D0,                       --                                            .hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1                       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D1,                       --                                            .hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK                      => CONNECTED_TO_hps_io_hps_io_sdio_inst_CLK,                      --                                            .hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2                       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D2,                       --                                            .hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3                       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D3,                       --                                            .hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D0,                       --                                            .hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D1,                       --                                            .hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D2,                       --                                            .hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D3,                       --                                            .hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D4,                       --                                            .hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D5,                       --                                            .hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D6,                       --                                            .hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7                       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D7,                       --                                            .hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK                      => CONNECTED_TO_hps_io_hps_io_usb1_inst_CLK,                      --                                            .hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP                      => CONNECTED_TO_hps_io_hps_io_usb1_inst_STP,                      --                                            .hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR                      => CONNECTED_TO_hps_io_hps_io_usb1_inst_DIR,                      --                                            .hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT                      => CONNECTED_TO_hps_io_hps_io_usb1_inst_NXT,                      --                                            .hps_io_usb1_inst_NXT
			hps_io_hps_io_spim1_inst_CLK                     => CONNECTED_TO_hps_io_hps_io_spim1_inst_CLK,                     --                                            .hps_io_spim1_inst_CLK
			hps_io_hps_io_spim1_inst_MOSI                    => CONNECTED_TO_hps_io_hps_io_spim1_inst_MOSI,                    --                                            .hps_io_spim1_inst_MOSI
			hps_io_hps_io_spim1_inst_MISO                    => CONNECTED_TO_hps_io_hps_io_spim1_inst_MISO,                    --                                            .hps_io_spim1_inst_MISO
			hps_io_hps_io_spim1_inst_SS0                     => CONNECTED_TO_hps_io_hps_io_spim1_inst_SS0,                     --                                            .hps_io_spim1_inst_SS0
			hps_io_hps_io_uart0_inst_RX                      => CONNECTED_TO_hps_io_hps_io_uart0_inst_RX,                      --                                            .hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX                      => CONNECTED_TO_hps_io_hps_io_uart0_inst_TX,                      --                                            .hps_io_uart0_inst_TX
			hps_io_hps_io_i2c0_inst_SDA                      => CONNECTED_TO_hps_io_hps_io_i2c0_inst_SDA,                      --                                            .hps_io_i2c0_inst_SDA
			hps_io_hps_io_i2c0_inst_SCL                      => CONNECTED_TO_hps_io_hps_io_i2c0_inst_SCL,                      --                                            .hps_io_i2c0_inst_SCL
			hps_io_hps_io_i2c1_inst_SDA                      => CONNECTED_TO_hps_io_hps_io_i2c1_inst_SDA,                      --                                            .hps_io_i2c1_inst_SDA
			hps_io_hps_io_i2c1_inst_SCL                      => CONNECTED_TO_hps_io_hps_io_i2c1_inst_SCL,                      --                                            .hps_io_i2c1_inst_SCL
			hps_io_hps_io_gpio_inst_GPIO09                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO09,                   --                                            .hps_io_gpio_inst_GPIO09
			hps_io_hps_io_gpio_inst_GPIO35                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO35,                   --                                            .hps_io_gpio_inst_GPIO35
			hps_io_hps_io_gpio_inst_GPIO40                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO40,                   --                                            .hps_io_gpio_inst_GPIO40
			hps_io_hps_io_gpio_inst_GPIO48                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO48,                   --                                            .hps_io_gpio_inst_GPIO48
			hps_io_hps_io_gpio_inst_GPIO53                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO53,                   --                                            .hps_io_gpio_inst_GPIO53
			hps_io_hps_io_gpio_inst_GPIO54                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO54,                   --                                            .hps_io_gpio_inst_GPIO54
			hps_io_hps_io_gpio_inst_GPIO61                   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO61,                   --                                            .hps_io_gpio_inst_GPIO61
			memory_mem_a                                     => CONNECTED_TO_memory_mem_a,                                     --                                      memory.mem_a
			memory_mem_ba                                    => CONNECTED_TO_memory_mem_ba,                                    --                                            .mem_ba
			memory_mem_ck                                    => CONNECTED_TO_memory_mem_ck,                                    --                                            .mem_ck
			memory_mem_ck_n                                  => CONNECTED_TO_memory_mem_ck_n,                                  --                                            .mem_ck_n
			memory_mem_cke                                   => CONNECTED_TO_memory_mem_cke,                                   --                                            .mem_cke
			memory_mem_cs_n                                  => CONNECTED_TO_memory_mem_cs_n,                                  --                                            .mem_cs_n
			memory_mem_ras_n                                 => CONNECTED_TO_memory_mem_ras_n,                                 --                                            .mem_ras_n
			memory_mem_cas_n                                 => CONNECTED_TO_memory_mem_cas_n,                                 --                                            .mem_cas_n
			memory_mem_we_n                                  => CONNECTED_TO_memory_mem_we_n,                                  --                                            .mem_we_n
			memory_mem_reset_n                               => CONNECTED_TO_memory_mem_reset_n,                               --                                            .mem_reset_n
			memory_mem_dq                                    => CONNECTED_TO_memory_mem_dq,                                    --                                            .mem_dq
			memory_mem_dqs                                   => CONNECTED_TO_memory_mem_dqs,                                   --                                            .mem_dqs
			memory_mem_dqs_n                                 => CONNECTED_TO_memory_mem_dqs_n,                                 --                                            .mem_dqs_n
			memory_mem_odt                                   => CONNECTED_TO_memory_mem_odt,                                   --                                            .mem_odt
			memory_mem_dm                                    => CONNECTED_TO_memory_mem_dm,                                    --                                            .mem_dm
			memory_oct_rzqin                                 => CONNECTED_TO_memory_oct_rzqin,                                 --                                            .oct_rzqin
			photodiode_0_conduit_end_export0                 => CONNECTED_TO_photodiode_0_conduit_end_export0,                 --                    photodiode_0_conduit_end.export0
			photodiode_0_conduit_end_export1                 => CONNECTED_TO_photodiode_0_conduit_end_export1,                 --                                            .export1
			photodiode_0_conduit_end_export2                 => CONNECTED_TO_photodiode_0_conduit_end_export2,                 --                                            .export2
			photodiode_0_conduit_end_export3                 => CONNECTED_TO_photodiode_0_conduit_end_export3,                 --                                            .export3
			photodiode_0_conduit_end_export4                 => CONNECTED_TO_photodiode_0_conduit_end_export4,                 --                                            .export4
			photodiode_0_conduit_end_export5                 => CONNECTED_TO_photodiode_0_conduit_end_export5,                 --                                            .export5
			photodiode_0_conduit_end_export6                 => CONNECTED_TO_photodiode_0_conduit_end_export6,                 --                                            .export6
			photodiode_0_conduit_end_export7                 => CONNECTED_TO_photodiode_0_conduit_end_export7,                 --                                            .export7
			pll_0_outclk0_clk                                => CONNECTED_TO_pll_0_outclk0_clk,                                --                               pll_0_outclk0.clk
			red_leds_external_connection_export              => CONNECTED_TO_red_leds_external_connection_export,              --                red_leds_external_connection.export
			reset_reset_n                                    => CONNECTED_TO_reset_reset_n,                                    --                                       reset.reset_n
			switches_external_connection_export              => CONNECTED_TO_switches_external_connection_export               --                switches_external_connection.export
		);

