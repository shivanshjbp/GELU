`timescale 1ns/1ps

module ITAGelu (
  input  wire          io_clk,
  input  wire          io_rst_ni,
  input  wire [15:0]   io_b_i,
  input  wire [15:0]   io_c_i,
  input  wire          io_calc_en_i,
  input  wire          io_calc_en_q_i,
  input  wire [7:0]    io_data_i,
  output wire [25:0]   io_data_o
);

  wire       [15:0]   _zz_coreArea_erf_abs;
  wire       [15:0]   _zz_coreArea_erf_clipped;
  wire       [15:0]   _zz_coreArea_erf_clipped_1;
  wire       [25:0]   _zz_coreArea_poly_sq_d;
  wire       [31:0]   _zz_coreArea_poly_sq_d_1;
  wire       [25:0]   _zz_coreArea_erf_L_q1;
  wire       [25:0]   _zz_coreArea_gelu_erf_q1;
  wire       [25:0]   _zz_coreArea_gelu_sum_q1;
  wire       [25:0]   _zz_coreArea_gelu_out_q1;
  wire       [33:0]   _zz_coreArea_gelu_out_q1_1;
  reg        [15:0]   coreArea_c_q1;
  reg        [7:0]    coreArea_data_q1;
  reg                 coreArea_erf_sgn_q1;
  reg        [25:0]   coreArea_poly_sq_q1;
  reg        [25:0]   coreArea_gelu_out_q2;
  wire       [15:0]   coreArea_data_sign_ext;
  wire                coreArea_erf_sgn_d;
  wire       [15:0]   coreArea_erf_abs;
  wire       [15:0]   coreArea_erf_clipped;
  wire       [15:0]   coreArea_poly_d;
  wire       [25:0]   coreArea_poly_sq_d;
  wire       [25:0]   coreArea_erf_L_q1;
  wire       [25:0]   coreArea_gelu_erf_q1;
  wire       [25:0]   coreArea_gelu_sum_q1;
  wire       [25:0]   coreArea_gelu_out_q1;

  assign _zz_coreArea_erf_abs = (- coreArea_data_sign_ext);
  assign _zz_coreArea_erf_clipped = (- io_b_i);
  assign _zz_coreArea_erf_clipped_1 = (- io_b_i);
  assign _zz_coreArea_poly_sq_d_1 = ($signed(coreArea_poly_d) * $signed(coreArea_poly_d));
  assign _zz_coreArea_poly_sq_d = _zz_coreArea_poly_sq_d_1[25:0];
  assign _zz_coreArea_erf_L_q1 = {{10{coreArea_c_q1[15]}}, coreArea_c_q1};
  assign _zz_coreArea_gelu_erf_q1 = (- coreArea_erf_L_q1);
  assign _zz_coreArea_gelu_sum_q1 = {{10{coreArea_c_q1[15]}}, coreArea_c_q1};
  assign _zz_coreArea_gelu_out_q1_1 = ($signed(coreArea_data_q1) * $signed(coreArea_gelu_sum_q1));
  assign _zz_coreArea_gelu_out_q1 = _zz_coreArea_gelu_out_q1_1[25:0];
  assign coreArea_data_sign_ext = {{8{io_data_i[7]}}, io_data_i};
  assign coreArea_erf_sgn_d = ($signed(io_data_i) < $signed(8'h0));
  assign coreArea_erf_abs = (coreArea_erf_sgn_d ? _zz_coreArea_erf_abs : coreArea_data_sign_ext);
  assign coreArea_erf_clipped = (($signed(_zz_coreArea_erf_clipped) < $signed(coreArea_erf_abs)) ? _zz_coreArea_erf_clipped_1 : coreArea_erf_abs);
  assign coreArea_poly_d = ($signed(coreArea_erf_clipped) + $signed(io_b_i));
  assign coreArea_poly_sq_d = (io_calc_en_i ? _zz_coreArea_poly_sq_d : coreArea_poly_sq_q1);
  assign coreArea_erf_L_q1 = ($signed(coreArea_poly_sq_q1) + $signed(_zz_coreArea_erf_L_q1));
  assign coreArea_gelu_erf_q1 = (coreArea_erf_sgn_q1 ? _zz_coreArea_gelu_erf_q1 : coreArea_erf_L_q1);
  assign coreArea_gelu_sum_q1 = ($signed(coreArea_gelu_erf_q1) + $signed(_zz_coreArea_gelu_sum_q1));
  assign coreArea_gelu_out_q1 = (io_calc_en_q_i ? _zz_coreArea_gelu_out_q1 : coreArea_gelu_out_q2);
  assign io_data_o = coreArea_gelu_out_q2;
  always @(posedge io_clk or negedge io_rst_ni) begin
    if(!io_rst_ni) begin
      coreArea_c_q1 <= 16'h0;
      coreArea_data_q1 <= 8'h0;
      coreArea_erf_sgn_q1 <= 1'b0;
      coreArea_poly_sq_q1 <= 26'h0;
      coreArea_gelu_out_q2 <= 26'h0;
    end else begin
      coreArea_c_q1 <= io_c_i;
      coreArea_data_q1 <= io_data_i;
      coreArea_erf_sgn_q1 <= coreArea_erf_sgn_d;
      coreArea_poly_sq_q1 <= coreArea_poly_sq_d;
      coreArea_gelu_out_q2 <= coreArea_gelu_out_q1;
    end
  end


endmodule