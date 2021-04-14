ALTER TABLE ofMucRoom ADD COLUMN fmucEnabled INT NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundNode NVARCHAR(255) NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucOutboundMode INT NULL;
ALTER TABLE ofMucRoom ADD COLUMN fmucInboundNodes NVARCHAR(2000) NULL;
ALTER TABLE ofmucroom CHANGE COLUMN subject subject TEXT NULL DEFAULT NULL;
ALTER TABLE ofmucconversationlog CHANGE COLUMN subject subject TEXT NULL DEFAULT NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN stanzaID NVARCHAR(64) NULL;
ALTER TABLE ofmucconversationlog ADD COLUMN status INT DEFAULT 0;

# set stanzaID of old conversation logs
update ofmucconversationlog set stanzaID=SUBSTR(stanza, 14, LOCATE('"', stanza, 14) - 14) WHERE stanza IS NOT null AND SUBSTR(stanza, 1, 12) = '<message id=';

CREATE INDEX ofMucConvLog_stanza_id ON ofMucConversationLog (stanzaID);
CREATE INDEX ofMucConvLog_status ON ofMucConversationLog (status);
CREATE INDEX ofMucConvLog_nickname ON ofMucConversationLog (nickname);

UPDATE ofVersion SET version = 32 WHERE name = 'openfire';
