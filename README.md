# Picture-HEX-Crypter:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![Picture HEX Crypter](https://github.com/user-attachments/assets/053c182f-1cce-4837-948d-9beb64eebe0d)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![112025](https://github.com/user-attachments/assets/6c049038-ad2c-4fe3-9b7e-1ca8154910c2)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>


Hexadecimal is a [positional numeral system](https://en.wikipedia.org/wiki/Numeral_system#Positional_systems_in_detail) for representing a numeric value as [base](https://en.wikipedia.org/wiki/Radix) 16. For the most common convention, a digit is represented as "0" to "9" like for [decimal](https://en.wikipedia.org/wiki/Decimal) and as a letter of the alphabet from "A" to "F" (either upper or lower case) for the digits with decimal value 10 to 15.

As typical computer hardware is [binary](https://en.wikipedia.org/wiki/Binary_number) in nature and that hex is [power of 2](https://en.wikipedia.org/wiki/Power_of_two), the hex representation is often used in computing as a dense representation of binary information. A hex digit represents 4 contiguous [bits](https://en.wikipedia.org/wiki/Bit) – known as a nibble. An 8-bit byte is two hex digits, such as 2C.

Special notation is often used to indicate that a number is hex. In [mathematics](https://en.wikipedia.org/wiki/Mathematics), a subscript is typically used to specify the base. For example, the decimal value 491 would be expressed in hex as 1EB16. In computer programming, various notations are used. In C and many related languages, the prefix 0x is used. For example, 0x1EB.

</br>

![Picture HEX](https://github.com/user-attachments/assets/2f2acfe0-3b6a-4825-9675-cdb393a7ed44)

</br>

Import/Export Picture Formats : BMP, PNG, JPG, GIF

### Common convention:
Typically, a hex representation convention allows either lower or upper case letters and treats the letter the same regardless of its case.

Often when rendering non-textual data, a value stored in memory is displayed as a sequence of hex digits with spaces that between values. For instance, in the following [hex dump](https://en.wikipedia.org/wiki/Hex_dump), each 8-bit byte is a 2-digit hex number, with spaces between them, while the 32-bit offset at the start is an 8-digit hex number.

```pascal
00000000  57 69 6B 69 70 65 64 69  61 2C 20 74 68 65 20 66 
00000010  72 65 65 20 65 6E 63 79  63 6C 6F 70 65 64 69 61 
00000020  20 74 68 61 74 20 61 6E  79 6F 6E 65 20 63 61 6E
00000030  20 65 64 69 74 2C 20 69  6E 63 6C 75 64 69 6E 67
00000040  20 79 6F 75 20 28 61 6E  64 20 6D 65 29 21
```
</br>

### Convert Examples:
```pascal
procedure Hex2Png(str: string; out png: TPngObject);
var  stream: TMemoryStream;
begin
  if not Assigned(png) then png := TPngObject.Create;
  stream := TMemoryStream.Create;
  stream.SetSize(Length(str) div 2);
  HexToBin(PChar(str), stream.Memory, stream.Size);
  png.LoadFromStream(stream);
  stream.Free;
end;

function Png2Hex(png: TPngObject): string;
var  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  png.SaveToStream(stream);
  SetLength(Result, stream.Size * 2);
  BinToHex(stream.Memory, PChar(Result), stream.Size);
  stream.Free;
end;

function bmp2Hex(out bmp: TBitmap):string;
var  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  bmp.SaveToStream(stream);
  SetLength(Result, stream.Size * 2);
  BinToHex(stream.Memory, PChar(Result), stream.Size);
  stream.Free;
end;

procedure Hex2bmp(str: string; out bmp: TBitmap);
var  stream: TMemoryStream;
begin
   if not Assigned(bmp) then bmp := TBitmap.Create;
   stream := TMemoryStream.Create;
   stream.SetSize(Length(str) div 2);
   HexToBin(PChar(str), stream.Memory, stream.Size);
   bmp.LoadFromStream(stream);
   stream.Free;
end;
```
</br>

# XOR cipher:
In [cryptography](https://en.wikipedia.org/wiki/Cryptography), the simple XOR cipher is a type of additive cipher,[1] an encryption algorithm that operates according to the principles:

```pascal
A ⊕ 0 = A,
A ⊕ A = 0,
A ⊕ B = B ⊕ A,
(A ⊕ B) ⊕ C = A ⊕ (B ⊕ C),
(B ⊕ A) ⊕ A = B ⊕ 0 = B
```
</br>

For example where ⊕ denotes the [exclusive](https://en.wikipedia.org/wiki/Exclusive_disjunction) disjunction (XOR) operation. This operation is sometimes called modulus 2 addition (or subtraction, which is identical). With this logic, a string of text can be encrypted by applying the bitwise XOR operator to every character using a given key. To decrypt the output, merely reapplying the XOR function with the key will remove the cipher.

The string "Wiki" (01010111 01101001 01101011 01101001 in 8-bit ASCII) can be encrypted with the repeating key 11110011 as follows:

```pascal
01010111 01101001 01101011 01101001
⊕	11110011 11110011 11110011 11110011
=	10100100 10011010 10011000 10011010

And conversely, for decryption:

10100100 10011010 10011000 10011010
⊕	11110011 11110011 11110011 11110011
=	01010111 01101001 01101011 01101001
```

</br>

The XOR operator is extremely common as a component in more complex ciphers. By itself, using a constant repeating key, a simple XOR cipher can trivially be broken using [frequency analysis](https://en.wikipedia.org/wiki/Frequency_analysis). If the content of any message can be guessed or otherwise known then the key can be revealed. Its primary merit is that it is simple to implement, and that the XOR operation is computationally inexpensive. A simple repeating XOR (i.e. using the same key for xor operation on the whole data) cipher is therefore sometimes used for hiding information in cases where no particular security is required. The XOR cipher is often used in computer [malware](https://en.wikipedia.org/wiki/Malware) to make [reverse engineering](https://en.wikipedia.org/wiki/Reverse_engineering) more difficult.

If the key is random and is at least as long as the message, the XOR cipher is much more secure than when there is key repetition within a message. When the [keystream](https://en.wikipedia.org/wiki/Keystream) is generated by a [pseudo-random](https://en.wikipedia.org/wiki/Pseudorandom_number_generator) number generator, the result is a [stream cipher](https://en.wikipedia.org/wiki/Stream_cipher). With a key that is [truly random](https://en.wikipedia.org/wiki/Hardware_random_number_generator), the result is a one-time pad, which is unbreakable in theory.

```pascal
s:= Memo1.Lines.Text;
      for i:=1 to length(s) do
        s[i]:=char(23 Xor ord(s[i])); // 23 is the Security Key
      Memo1.Lines.Text := s;
```



