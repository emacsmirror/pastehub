#
# crypt.rb - PasteHub's encrypt/decrypt library
#  
#   Copyright (c) 2009-2011  Kiyoka Nishiyama  <kiyoka@sumibi.org>
#   
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions
#   are met:
#   
#   1. Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#  
#   2. Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#  
#   3. Neither the name of the authors nor the names of its contributors
#      may be used to endorse or promote products derived from this
#      software without specific prior written permission.
#  
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
#   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
#   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#  
#
require 'openssl'
require 'base64'

module PasteHub
  class Crypt
    def initialize( password )
      @password = password
      @des3 = OpenSSL::Cipher.new('des3')
    end

    def en( str )
      if 0 == str.size
        ""
      else
        @des3.encrypt
        @des3.pkcs5_keyivgen( @password )
        Base64.encode64( @des3.update( str ) + @des3.final )
      end
    end

    def de( str )
      if 0 == str.size
        ""
      else
        begin
          @des3.decrypt
          @des3.pkcs5_keyivgen( @password )
          ret =  @des3.update( Base64.decode64( str ))
          ret += @des3.final
        rescue OpenSSL::Cipher::CipherError => e
          ret = nil
        end
        ret
      end
    end
  end
end
