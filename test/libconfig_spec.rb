#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# libconfig_spec.rb -  "RSpec file for config.rb"
#
#   Copyright (c) 2012-2012  Kiyoka Nishiyama  <kiyoka@sumibi.org>
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
require 'pastehub'

describe PasteHub::Config, "When use config object...  " do

  before do
    @config = PasteHub::Config.instance
  end

  it "should" do
    @config.dbPath.should              == "/var/pastehub/"
    @config.memcacheHost.should        == "localhost:11211"
    @config.targetApiHost.should       == "pastehub.org:8000"
    @config.targetNotifierHost.should  == "pastehub.org:8001"
    @config.localDbPath.should         == File.expand_path( "~/.pastehub/" ) + "/"
  end
end


describe PasteHub::Config, "When use config object...  " do

  before do
    @config = PasteHub::Config.instance
    @config.setupServer( "/tmp/", "memcache.example.com:11211" )
    @config.setupClient( "localhost:8000", "localhost:8001", "/tmp/local/" )
  end

  it "should" do
    @config.dbPath.should              == "/tmp/"
    @config.memcacheHost.should        == "memcache.example.com:11211"
    @config.targetApiHost.should       == "localhost:8000"
    @config.targetNotifierHost.should  == "localhost:8001"
    @config.localDbPath.should         == "/tmp/local/"
  end
end