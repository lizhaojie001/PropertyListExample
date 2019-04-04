import java.io.*;
import java.util.Arrays;

public class TsDecrypt {

    private final long ACTION_PREPARE_FROM_SEARCH = 65536;
    private final String CYPHER_FILE = "D:\\test\\Cypher_File_Java.ts";
    private final String DECRYPTED_FILE = "D:\\test\\Decrypted_File_Java.ts";

    private byte[] getDecryptByte(long encryptKey) {
        int[] lista = {(int)((encryptKey / 16777216) % 256),
                (int)((encryptKey / ACTION_PREPARE_FROM_SEARCH) % 256),
                (int)((encryptKey / 256) % 256),
                (int)(encryptKey % 256),
        };
        System.out.println(Arrays.toString(lista));
        byte[] listb = {(byte)lista[0], (byte)lista[1], (byte)lista[2], (byte)lista[3]};
        System.out.println(bytesToHexString(listb));
        return listb;
    }

    private void decryptData(long encryptKey) {
        File encryptFile = new File(CYPHER_FILE);
        File tempFile = new File(DECRYPTED_FILE);

        if (tempFile.exists()) {
            tempFile.deleteOnExit();
        }
        try {
            tempFile.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (encryptFile.isFile()) {
            ByteArrayOutputStream bos = new ByteArrayOutputStream((int)encryptFile.length());
            BufferedInputStream inputStream = null;

            try {
                inputStream = new BufferedInputStream(new FileInputStream(encryptFile));
                int bufferSize = 1024;
                byte[] buffer = new byte[bufferSize];
                int length = 0;
                while (-1 != (length = inputStream.read(buffer, 0, bufferSize))) {
                    bos.write(buffer, 0, length);
                }
                byte[] ttarray = bos.toByteArray();

                DataOutputStream dos = null;
                try {
                    dos = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(tempFile, true)));
                    System.out.println("开始解密...");
                    int i = 0;
                    byte[] decryptByteArray = getDecryptByte(encryptKey);
                    System.out.println(decryptByteArray.length);
                    for (byte tsone : ttarray) {
                        if (i < ttarray.length) {
                            int tsbyte = (tsone ^ (decryptByteArray[i % 4]));
                            i = i + 1;
                            byte[] tsbyteArray = new byte[]{(byte)tsbyte};
                            System.out.println(bytesToHexString(tsbyteArray));
                            dos.write(tsbyteArray);
                            dos.flush();
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    System.out.println("解密完成");
                    try {
                        dos.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                try {
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            System.out.println("File is not found");
        }
    }

    private String bytesToHexString(byte[] src){
        StringBuilder stringBuilder = new StringBuilder("");
        if (src == null || src.length <= 0) {
            return null;
        }
        for (int i = 0; i < src.length; i++) {
            int v = src[i] & 0xFF;
            String hv = Integer.toHexString(v);
            if (hv.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(hv);
        }
        return stringBuilder.toString();
    }

    public static void main(String[] args) {
        TsDecrypt tsDecrypt = new TsDecrypt();

        long encryptKey = 612400680;
        tsDecrypt.decryptData(encryptKey);
    }
}
