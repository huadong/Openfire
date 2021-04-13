ALTER TABLE ofMucRoom ADD COLUMN fmucEnabled INTEGER NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundNode VARCHAR(255) NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundMode INTEGER NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucInboundNodes VARCHAR(4000) NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN stanzaID VARCHAR(64) NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN status INTEGER DEFAULT 0;

# set stanzaID of old conversation logs
update ofmucconversationlog set stanzaID=SUBSTR(stanza, 14, LOCATE('"', stanza, 14) - 14) WHERE stanza IS NOT null AND SUBSTR(stanza, 1, 12) = '<message id=';

CREATE INDEX ofMucConvLog_stanza_id ON ofMucConversationLog (stanzaID);
CREATE INDEX ofMucConvLog_status ON ofMucConversationLog (status);

UPDATE ofVersion SET version = 32 WHERE name = 'openfire';
