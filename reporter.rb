require 'json'
require_relative  'features/support/api_helper.rb'



thumbnail={'url'=>'https://i.imgur.com/B2XMuqi.jpg'}
fields=[]
embed=[]
fields.push({'name'=>'Author','value'=>'US'})
fields.push({'name'=>'Position','value'=>'QA Engineer'})
embed.push({'title'=>'Rich content (cmon)',
                'color'=>6288450,
                'thumbnail'=>thumbnail,
                'fields'=>fields})


payload={'content'=>'Automatic message','embeds'=>embed}.to_json

post('https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1',
     headers: {'Content-Type'=>'application/json'},
     cookies: {},
     payload: payload)