#encoding:utf-8
from flask import Flask
from flask import request
app = Flask(__name__)
app.config.from_object('config.Config')
app.config.from_object('config.TrelloConfig')

@app.route('/')
def hello_world():
    return 'Hello World!!'

def PostToTrelloCard(text):
    import trollop
    conn = trollop.TrelloConnection(app.config['MY_APIKEY'], app.config['MY_TOKEN']);
    if len(text) > 0:
        conn.post('/cards/%s/actions/comments' % app.config['MY_CARDID'], {'text': text})
    else:
        return app.config['MY_CARDID']

@app.route('/new_text', methods=['GET', 'POST'])
def post_text_to_trello():
    data = request.form
    text = []
    for (k,v) in data.iteritems():
        text.append("%s:%s" % (k, v.encode('utf-8')))

    post = ', '.join(text)
    PostToTrelloCard(post)
    return post

@app.route('/test', methods=['GET', 'POST'])
def post_test():
    PostToTrelloCard('test')
    return 'test'

if __name__ == '__main__':
    app.run()
