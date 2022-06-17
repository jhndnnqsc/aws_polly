aws = require("aws-auth")

local polly = {}

neuralVoices = {
  "Amy", "Brian", "Camila", "Emma", "Ivy", "Joanna", "Joey", "Justin", 
  "Kendra", "Kevin", "Kimberly",  "Lupe", "Matthew", "Olivia",  "Salli", "Seoyeon"
}

standardVoices = {
  "Aditi", "Astrid", "Bianca", "Carla", "Carmen", "Celine", "Chantal", "Conchita",
  "Cristiano", "Dora", "Enrique", "Ewa", "Filiz", "Geraint", "Giorgio", "Gwyneth",
  "Hans", "Ines", "Jacek", "Jan", "Karl", "Lea", "Liv", "Lotte", "Lucia", "Mads",
  "Maja", "Marlene", "Mathieu", "Maxim", "Mia", "Miguel", "Mizuki", "Naja", "Nicole",
  "Penelope", "Raveena", "Ricardo", "Ruben", "Russell", "Takumi", "Tatyana", "Vicki", 
  "Vitoria", "Zeina", "Zhiyu"
}

polly.Voices = {}

for k,v in pairs(neuralVoices) do table.insert(polly.Voices, v) end
for k,v in pairs(standardVoices) do table.insert(polly.Voices, v) end

polly.DefaultVoice = "Joanna"

polly.Languages = {
  "arb", "cmn-CN", "cy-GB", "da-DK", "de-DE", "en-AU", "en-GB", "en-GB-WLS",
  "en-IN", "en-US", "es-ES", "es-MX", "es-US", "fr-CA", "fr-FR", "is-IS",
  "it-IT", "ja-JP", "hi-IN", "ko-KR", "nb-NO", "nl-NL", "pl-PL", "pt-BR",
  "pt-PT", "ro-RO", "ru-RU", "sv-SE", "tr-TR"
}

polly.DefaultLanguage = "en-US"

polly.SynthesizeVoice = function(data)

  -- determine which engine to use
  local engine = "standard"
  for k,v in pairs(neuralVoices) do
    if v == voice then engine = "neural" end
  end
  
  -- https://docs.aws.amazon.com/polly/latest/dg/API_SynthesizeSpeech.html
  local payload = {
    Engine = engine,
    LanguageCode = data.Language,
    OutputFormat = "mp3",
    Text = "<speak>"..data.Text.."</speak>",
    TextType = "ssml",
    VoiceId = data.Voice
  } 
 
 
  local rq = {  
    Region = "us-east-1",
    Service = "polly",
    URI = "/v1/speech", 
    ContentType = "application/json",
    Payload = json.encode(payload),
    AccessId = data.AccessId,
    AccessKey = data.AccessKey
  }
 
  local signedRequest = aws.GetSignedRequest(rq)

  signedRequest.EventHandler = function(_, c, d, e ) data.EventHandler(c, d, e ) end
  
  HttpClient.Upload(signedRequest)
end

return polly
