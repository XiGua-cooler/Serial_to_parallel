//////////////////////////////////////////////////////////////////////////////////
// Engineer: XiGua
// 
// Create Date: 2021/05/04 22:56:19
// Design Name: Paller to Serial
// Module Name: p_to_s
// Target Devices: ALL FPGA
// Tool Versions: V1.0
// Description: 
//////////////////////////////////////////////////////////////////////////////////
module p_to_s(
    input           reset, //It is glable reset.
    input reg[5 :0] paller_data_width,  //Indicating the paller data width.
                                        //Range is 0 to 63;
    input           paller_data, //It is the paller data.
    input           serial_clk, //Indicating the serial data clock.
                                //Notes: !!IT MUST BE THE "paller_data_width" * "paller_clk"!!
                                //Notes: First data is the LSB of "paller_data".
    input           en, //When it stes in "1",the module will be enable,when it is "0" it will be disable.

    output reg      serial_data
    );
    
    reg[5 :0]             bit_cnt;   //Range is 0 to 62; 

    always @(posedge serial_clk or negedge reset) begin
        if(reset == 1'b0)begin
            serial_data <= 1'b0;
            bit_cnt <= 6'd0;
        end
        else if(en == 1'b1)begin
            serial_data <= paller_data[bit_cnt];
            if(bit_cnt == paller_data_width)begin
                bit_cnt <= 6'd0;
            end
            else begin
                bit_cnt <= bit_cnt + 1'd1;
            end
        end
        else begin
            serial_data <= 1'b0;
            bit_cnt <= 6'd0;
        end
    end


endmodule
