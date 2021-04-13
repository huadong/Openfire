ALTER TABLE ofMucRoom ADD COLUMN fmucEnabled INTEGER NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundNode TEXT NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundMode INTEGER NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucInboundNodes TEXT NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN stanzaID TEXT NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN status INTEGER DEFAULT 0;

# set stanzaID of old conversation logs
update ofmucconversationlog set stanzaID=SPLIT_PART(stanza, '"', 2) WHERE stanza IS NOT null AND SUBSTRING(stanza, 1, 12) = '<message id=';

CREATE INDEX ofMucConvLog_stanza_id ON ofMucConversationLog (stanzaID);
CREATE INDEX ofMucConvLog_status ON ofMucConversationLog (status);

UPDATE ofVersion SET version = 32 WHERE name = 'openfire';
