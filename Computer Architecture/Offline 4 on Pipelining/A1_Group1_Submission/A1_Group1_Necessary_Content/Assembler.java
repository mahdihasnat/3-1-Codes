import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.Vector;
import java.util.HashMap;
import java.io.PrintWriter;

public class Assembler {

    public static void main(String[] args) {
        PrintWriter pw = null;

        try {
            pw = new PrintWriter("ControlUnit.hex","UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // write control unit codes to ControlUnit.hex file 
        // use this version for pipelining 
        pw.println("v2.0 raw");
        pw.println("063"); 
        pw.println("033"); 
        pw.println("841"); 
        pw.println("220");  
        pw.println("853"); 
        pw.println("110");  
        pw.println("053");  
        pw.println("023"); 
        pw.println("831"); 
        pw.println("821");  
        pw.println("863");  
        pw.println("851"); 
        pw.println("861"); 
        pw.println("0d6"); 
        pw.println("0db"); 
        pw.println("430");  
        pw.close();

        Scanner scanner=null;

        try {
            scanner=new Scanner(new File("input.txt"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        Vector<String> hex_code=new Vector<>();
        HashMap<String,Integer> labels=new HashMap<String, Integer>();

        String line;
        String[] instructions;
        String [] comment;
        int lineNumber=0;
        int st_count = 0, cst_count = 0;
        String commentSeparator = "#";
        String instPart = "";

        while(scanner.hasNext()) {
            line = scanner.nextLine();
            line = line.trim().replaceAll(" +"," ");
            if(line.equals("") || line.startsWith(commentSeparator)) {
                continue;
            }

            int is_label=0;
            if(line.contains(":")){
                is_label = 1;
            }

            instructions = line.split(":");

            comment = line.split(commentSeparator);
            if(comment.length >= 2){
                //if there is a comment
                hex_code.add(comment[0].trim());
                instPart = comment[0].trim();
                lineNumber++;
            }

            //System.out.println(line);
            //System.out.println(instructions[0]);

            else if (instructions.length == 2) {
                instructions[1]=instructions[1].trim();
                if (instructions[1].length() > 0) {
                    lineNumber++;
                    hex_code.add(instructions[1]);
                    instPart = instructions[1];
                }
                labels.put(instructions[0].trim(), lineNumber - 1);
            } else if (instructions.length == 1) {
                lineNumber++;
                if(is_label == 1){
                    labels.put(instructions[0].trim(), lineNumber - 1);
                }
                line=line.trim();
                hex_code.add(line);
                instPart = line;
            } else {
                System.out.println("Syntax Error at line " + lineNumber);
            }
            if(instPart.contains("push")) {
                if(st_count == 0) {
                    lineNumber++;
                }
                if(line.contains("(")) {
                    lineNumber++;
                }
                lineNumber++;
                st_count++;
                cst_count++;
            }
            if(instPart.contains("pop")) {
                if(st_count == 0) {
                    lineNumber--;
                }
                if(cst_count == 0) {
                    lineNumber--;
                }
                lineNumber++;
                cst_count--;
            }
            if(line.trim().endsWith(":")) {
                lineNumber--;
            }
            // System.out.print("lineNumber = " + lineNumber);
            // System.out.print(", line = " + line + "\n");
        }

        String code="";
        int immediate;

        PrintWriter printWriter=null;

        try {
            printWriter=new PrintWriter("InstructionMemory.hex","UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        String [] tokens;
        int count = 0;

        //stack init counter
        int stack_counter = 0;
        int current_stack_counter = 0;

        // write hex instructions to InstructionMemory.hex file
        printWriter.println("v2.0 raw");

        for(String s:hex_code){
            s = s.trim().replaceAll("[ ]{2,}", " ");
            String[] result = s.split(" ", 2);
            // for(String ss : result) System.out.println(ss);
            String rest="";
            String opcode="";
            if(result.length==2){
                opcode = result[0];
                rest = result[1];
                rest = rest.replace(" ","");

            }

            if(rest.trim().equals(":"))  continue;

            tokens=s.split(" ");

            if(tokens.length<=1){
                continue;
            }

            count++;

            if(opcode.contains("andi")) {
                code = "0000";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);         // opcode | rs | rd | address
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString8bit(immediate);
            }
            else if(opcode.contains("addi")) {
                code = "0001";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);         // opcode | rs | rd | address
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString8bit(immediate);
            }
            else if(opcode.contains("nor")) {
                code = "0010";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);        // opcode | rs | rt | rd | shift
                code += getRegisterCode(tokens[2]);
                code += getRegisterCode(tokens[0]);
                code += "0000";
            }
            else if(opcode.contains("bneq")) {
                code = "0011";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);        // opcode | rs | rd | address
                code += getRegisterCode(tokens[0]);
                code += intToString8bit(labels.get(tokens[2]) - count);
            }
            else if(opcode.contains("sll")) {
                code = "0100";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);       //opcode | rs | rt | rd | shft
                code += "0000";
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString4bit(immediate);
            }
            else if(opcode.contains("beq")) {
                code = "0101";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);
                code += getRegisterCode(tokens[0]);
                code += intToString8bit(labels.get(tokens[2]) - count);
            }
            else if(opcode.contains("ori")) {
                code = "0110";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);      // opcode | rs | rd | const
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString8bit(immediate);
            }
            else if(opcode.contains("subi")) {
                code = "0111";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);      // opcode | rs | rd | const
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString8bit(immediate);
            }
            else if(opcode.contains("add")) {
                code = "1000";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);     // opcode | rs | rt | rd | shift
                code += getRegisterCode(tokens[2]);
                code += getRegisterCode(tokens[0]);
                code += "0000";
            }
            else if(opcode.contains("sub")) {
                code = "1001";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);     // opcode | rs | rt | rd | shift
                code += getRegisterCode(tokens[2]);
                code += getRegisterCode(tokens[0]);
                code += "0000";
            }
            else if(opcode.contains("srl")) {
                code = "1010";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);
                code += "0000";
                code += getRegisterCode(tokens[0]);
                immediate = Integer.parseInt(tokens[2]);
                code += intToString4bit(immediate);
            }
            else if(opcode.contains("or")) {
                code = "1011";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);      // opcode | rs | rt | rd | shift
                code += getRegisterCode(tokens[2]);
                code += getRegisterCode(tokens[0]);
                code += "0000";
            }
            else if(opcode.contains("and")) {
                code = "1100";
                tokens = rest.split(",");
                code += getRegisterCode(tokens[1]);      // opcode | rs | rt | rd | shift
                code += getRegisterCode(tokens[2]);
                code += getRegisterCode(tokens[0]);
                code += "0000";
            }
            else if(opcode.contains("sw")) {
                code = "1101";
                tokens = rest.split(",");               // opcode | rs | rt | offset
                String rt = tokens[0];
                tokens = tokens[1].split("\\(");
                String rs = tokens[1].substring(0, tokens[1].length() - 1);
                code += getRegisterCode(rs);
                code += getRegisterCode(rt);
                code += intToString8bit(Integer.parseInt(tokens[0]));
            }
            else if(opcode.contains("lw")) {
                code = "1110";
                tokens = rest.split(",");               // opcode | rs | rt | offset
                String rt_ = tokens[0];
                tokens = tokens[1].split("\\(");
                String rs_ = tokens[1].substring(0, tokens[1].length() - 1);

                code += getRegisterCode(rs_);
                code += getRegisterCode(rt_);
                code += intToString8bit(Integer.parseInt(tokens[0]));
            }
            else if(opcode.contains("j")) {
                code = "1111";
                code += intToString8bit(labels.get(tokens[1]));  // opcode |  j | 0000 | 0000
                code += "00000000";

            }
            //------------------STACK PART----------------//
            else if(opcode.contains("push"))
            {
                stack_counter++;
                current_stack_counter++;
                //set sp =0xff for first push
                if(stack_counter == 1){
                    //addi $sp,$sp,0xff
                    code = "0001";

                    code += getRegisterCode("$sp");         // opcode | $sp | $sp | 255
                    code += getRegisterCode("$sp");

                    code += intToString8bit(255);
                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    count++;    // added one extra line
                }
                tokens = rest.split("\\(");
                //case: push $t0

                if(tokens.length ==1){
                    //System.out.println(tokens[0]);
                    //"push $t0"
                    //sw $t0, 0($sp)
                    //addi $sp, $sp, -1
                    //------------------sw part----------------//
                    code = "1101";
                    String rt = tokens[0];
                    String rs = "$sp";  // opcode | rs | rt | offset
                    code += getRegisterCode(rs);
                    code += getRegisterCode(rt);
                    code += intToString8bit(0);

                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    count++;
                    //------------end of sw ---------------//

                    //--------------addi part -------------//
                    code = "0001";
                    code += getRegisterCode("$sp");         // opcode | $sp | $sp| -1
                    code += getRegisterCode("$sp");

                    code += intToString8bit(-1);
                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    //--------------end of addi part------------//
                }
                else if(tokens.length == 2)
                {
                    //case :push 3($t0)
                    /*"push 3($t0)"
                    lw $t5, 3($t0)
                    sw $t5, 0($sp)
                    addi $sp, $sp, -1*/
                    String t_0 = tokens[1].substring(0, tokens[1].length() - 1);
                    String offset = tokens[0];
                    //-----------lw part -------------//
                    code = "1110";


                    String rt_ = "$t5";

                    String rs_ = t_0;

                    code += getRegisterCode(rs_);
                    code += getRegisterCode(rt_);
                    code += intToString8bit(Integer.parseInt(offset));
                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    count++;
                    //-----------end of lw ------------//

                    //---------------sw part -----------//
                    //sw $t1, 0($sp)
                    code = "1101";


                    String rt = "$t5";

                    String rs = "$sp";  // opcode | rs | rt | offset

                    code += getRegisterCode(rs);
                    code += getRegisterCode(rt);
                    code += intToString8bit(0);
                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    count++;

                    //--------------addi part -------------//
                    code = "0001";
                    code += getRegisterCode("$sp");         // opcode | $sp | $sp| -1
                    code += getRegisterCode("$sp");

                    code += intToString8bit(-1);
                    printWriter.println(codeToHex(code));
                    // System.out.println(codeToHex(code));
                    //--------------end of addi part------------//

                }
                //String rs_ = tokens[1].substring(0, tokens[1].length() - 1);


            }
            else if(opcode.contains("pop")){
                current_stack_counter--;
                if(stack_counter == 0){
                    System.out.println("error in pop");   //for popping first
                    count--;    // ignore the line count
                    continue;
                }
                if(current_stack_counter<0){
                    System.out.println("error in pop");
                    count--;    // ignore the line count
                    continue;
                }
                /*"pop $t0"
                addi $sp, $sp, 1
                lw $t0, 0($sp)*/
                //----------------addi part -------------//
                code = "0001";
                code += getRegisterCode("$sp");         // opcode | $sp | $sp| 1
                code += getRegisterCode("$sp");

                code += intToString8bit(1);
                printWriter.println(codeToHex(code));
                // System.out.println(codeToHex(code));
                count++;
                //----------------end of addi ------------//

                //-----------------lw part ------------//
                //lw $t0, 0($sp)
                code = "1110";


                String rt_ = rest;

                String rs_ = "$sp";

                code += getRegisterCode(rs_);
                code += getRegisterCode(rt_);
                code += intToString8bit(0);
                printWriter.println(codeToHex(code));
                // System.out.println(codeToHex(code));

            }

            //System.out.println(code);

            if(!opcode.contains("push") && !opcode.contains("pop")){
                printWriter.println(codeToHex(code));
                // System.out.println(codeToHex(code));
            }

        }
		System.out.println("\nInstruction Memory hex codes in InstructionMemory.hex");
		System.out.println("Control Unit hex codes in ControlUnit.hex\n");
        printWriter.close();

    }
    // Function to find two's complement
    public static String findTwoscomplement(StringBuilder str)
    {
        int n = str.length();

        // Traverse the string to get first '1' from
        // the last of string
        int i;
        for (i = n-1 ; i >= 0 ; i--)
            if (str.charAt(i) == '1')
                break;

        // If there exists no '1' concat 1 at the
        // starting of string
        if (i == -1)
            return "1" + str;

        // Continue traversal after the position of
        // first '1'
        for (int k = i-1 ; k >= 0; k--)
        {
            //Just flip the values
            if (str.charAt(k) == '1')
                str.replace(k, k+1, "0");
            else
                str.replace(k, k+1, "1");
        }

        // return the modified string
        return str.toString();
    }

    public static String intToString8bit(int number) {
        StringBuilder result = new StringBuilder();
        int is_neg = 0 ;
        if(number<0){
            //get value
            is_neg = 1;
            number = - number;
        }

        for(int i = 7; i >= 0 ; i--) {
            int mask = 1 << i;
            result.append((number & mask) != 0 ? "1" : "0");
        }
        if(is_neg == 1){
            //System.out.println(findTwoscomplement(result));
            return findTwoscomplement(result);
        }

        return result.toString();
    }
    public static String codeToHex(String code){
        String hex=Integer.toHexString((Integer.parseInt(code,2))); //convert to hex
        if(hex.length()!=5){
            for(int i=hex.length();i<5;i++){
                hex="0"+hex;
            }
        }
        return hex;
    }

    public static String intToString4bit(int number) {
        StringBuilder result = new StringBuilder();

        int is_neg = 0 ;
        if(number<0){
            //get value
            is_neg = 1;
            number = - number;
        }

        for(int i = 3; i >= 0 ; i--) {
            int mask = 1 << i;
            result.append((number & mask) != 0 ? "1" : "0");
        }
        if(is_neg == 1){
            return findTwoscomplement(result);
        }


        return result.toString();
    }

    static String getRegisterCode(String op){
        switch (op.toLowerCase()){
            case "$zero":
                return "0000";

            case "$t0":
                return "0001";

            case "$t1":
                return "0010";

            case "$t2":
                return "0011";

            case "$t3":
                return "0100";

            case "$t4":
                return "0101";

            case "$t5":
                return "0110";

            case "$sp":
                return "0111";

            default:
                return "";
        }
    }
}
