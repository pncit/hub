function New-CryptographyKey()
{
<#
.SYNOPSIS 
Generates a random cryptography key.

.DESCRIPTION
Generates a random cryptography key based on the desired key size.

.PARAMETER Algorithm
Algorithm to generate key for.

.PARAMETER KeySize
Number of bits the generated key will have.

.PARAMETER AsPlainText
Returns a String instead of SecureString.

.OUTPUTS
System.Security.SecureString. New-CryptographyKey return the key as a SecureString by default.
System.String. New-CryptographyKey will return the key in plain text as a string if the -AsPlainText parameter is specified.

.EXAMPLE
$key = New-CryptographyKey
This example generates a random 256-bit AES key and stores it in the variable $key.

.NOTES
Author: Tyler Siegrist
Date: 9/22/2017
Downloaded from https://gallery.technet.microsoft.com/scriptcenter/EncryptDecrypt-files-use-65e7ae5d on 3/8/2019

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

#>
[CmdletBinding()]
[OutputType([System.Security.SecureString])]
[OutputType([String], ParameterSetName='PlainText')]
Param(
    [Parameter(Mandatory=$false, Position=1)]
    [ValidateSet('AES','DES','RC2','Rijndael','TripleDES')]
    [String]$Algorithm='AES',
    [Parameter(Mandatory=$false, Position=2)]
    [Int]$KeySize,
    [Parameter(ParameterSetName='PlainText')]
    [Switch]$AsPlainText
)
    Process
    {
        try
        {
            $Crypto = [System.Security.Cryptography.SymmetricAlgorithm]::Create($Algorithm)
            if($PSBoundParameters.ContainsKey('KeySize')){
                $Crypto.KeySize = $KeySize
            }
            $Crypto.GenerateKey()
            if($AsPlainText)
            {
                return [System.Convert]::ToBase64String($Crypto.Key)
            }
            else
            {
                return [System.Convert]::ToBase64String($Crypto.Key) | ConvertTo-SecureString -AsPlainText -Force
            }
        }
        catch
        {
            Write-Error $_
        }
        
    }
}
