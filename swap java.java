import java.io.*;
 
// Driver Class
public class SwapVariables {
    // main function
    public static void main(String[] args)
    {
        int a = 5;
        int b = 10;
 
        // print statement
        System.out.println("Before swapping, a = " + a
                           + " and b = " + b);
 
        a = a + b;
        b = a - b;
        a = a - b;
 
        System.out.println("After swapping, a = " + a
                           + " and b = " + b);
    }
}