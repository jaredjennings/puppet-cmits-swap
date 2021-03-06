# % CMITS - Configuration Management for Information Technology Systems
# % Based on <https://github.com/afseo/cmits>.
# % Copyright 2015 Jared Jennings <mailto:jjennings@fastmail.fm>.
# %
# % Licensed under the Apache License, Version 2.0 (the "License");
# % you may not use this file except in compliance with the License.
# % You may obtain a copy of the License at
# %
# %    http://www.apache.org/licenses/LICENSE-2.0
# %
# % Unless required by applicable law or agreed to in writing, software
# % distributed under the License is distributed on an "AS IS" BASIS,
# % WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# % See the License for the specific language governing permissions and
# % limitations under the License.
class swap::encrypt::darwin_10_6 {
# \implements{macosxstig}{OSX00440 M6}%
# ``Use secure virtual memory,'' or in other words, make Macs encrypt their
# swap space.
    $vm = "/Library/Preferences/com.apple.virtualMemory.plist"
# The file may not exist; make sure it has the right ownership and permissions.
    file { $vm:
        ensure => present,
        owner => root, group => admin, mode => '0644',
    }
    mac_plist_value { "encrypt swap":
        require => File[$vm],
        file => $vm,
        key => 'UseEncryptedSwap',
        value => true,
    }
# \implements{mlionstig}{OSX8-00-01260}%
# Use ``secure virtual memory'' on newer Macs.
    mac_plist_value { "un-disable swap encryption":
        require => File[$vm],
        file => $vm,
        key => 'DisableEncryptedSwap',
        value => false,
    }
}
