# AWS Polly module

### _Module for text to speech using sending email using https://aws.amazon.com/polly/

### `DefaultLanguage`
Default language to use - `"en-US"`
### `DefaultVoice`
Default voice to use - `"Joanna"`
### `Languages`
List of available languages (strings)
### `Voices`
List of available voices (strings)
### `SynthesizeVoice(data)`
Synthesize text and get resultant audio file. The arguement has the following fields

* `AccessId` - AWS Access ID
* `AccessKey` - AWS Access Key
* `EventHandler` - HttpClient callback which contains audio
* `Language` - Language to use
* `Text` - text to synthesize
* `Voice` - Voice to use

Example

```
polly = require("aws-polly")
json = require('rapidjson')
fileName = "test.mp3"  

polly.SynthesizeVoice({
  AccessId = AWS_ACCESS_ID,
  AccessKey = AWS_ACCESS_KEY,
  Language = polly.DefaultLanguage,
  Voice = polly.DefaultVoice,
  Text = "helloe",
  EventHandler = function(code, data, err) 
    print("RESP: ",  code, err)
    if code == 200 then

      local file, err = io.open("media/Audio/"..fileName, "wb")
      file:write(data)
      file:close()
      
      -- since we are overwriting a file that the audio file player
      -- is currently pointed at we delay the start of the playback
      -- so it has a chance to load the new file. 
      Timer.CallAfter(function()
        -- trigger playback here
        -- Controls.play:Trigger() 
      end, 0.250 )
    end
  end
})
```



 
