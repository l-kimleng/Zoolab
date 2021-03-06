﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Zoolab.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201807280052074_AddModel'
BEGIN
    CREATE TABLE [dbo].[Beers] (
        [Id] [int] NOT NULL IDENTITY,
        [Brand] [nvarchar](255) NOT NULL,
        [Abv] [real] NOT NULL,
        CONSTRAINT [PK_dbo.Beers] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Pubs] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](255) NOT NULL,
        [Location] [nvarchar](255),
        [Rate] [real] NOT NULL,
        CONSTRAINT [PK_dbo.Pubs] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[PubBeers] (
        [Pub_Id] [int] NOT NULL,
        [Beer_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.PubBeers] PRIMARY KEY ([Pub_Id], [Beer_Id])
    )
    CREATE INDEX [IX_Pub_Id] ON [dbo].[PubBeers]([Pub_Id])
    CREATE INDEX [IX_Beer_Id] ON [dbo].[PubBeers]([Beer_Id])
    ALTER TABLE [dbo].[PubBeers] ADD CONSTRAINT [FK_dbo.PubBeers_dbo.Pubs_Pub_Id] FOREIGN KEY ([Pub_Id]) REFERENCES [dbo].[Pubs] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[PubBeers] ADD CONSTRAINT [FK_dbo.PubBeers_dbo.Beers_Beer_Id] FOREIGN KEY ([Beer_Id]) REFERENCES [dbo].[Beers] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201807280052074_AddModel', N'Zoolab.Migrations.Configuration',  0x1F8B0800000000000400ED19DB6ADC46F4BDD07F107A2CCECA7608B46637C15EDBC534BEE0B543E98B9995CEAE454733EACCC8EC12FA657DE827F5177A4677CD485AC9714C092560B23373EEF7A37FFEFA7BFA611351E709840C399BB907937DD701E6F32064EB999BA8D59B1FDD0FEFBFFF6E7A16441BE753F1EEAD7E87904CCEDC47A5E223CF93FE2344444EA2D0175CF2959AF83CF248C0BDC3FDFD9FBC83030F10858BB81C677A9B30154690FEC09F73CE7C885542E8250F80CAFC1C6F162956E78A442063E2C3CCFD8D734A96931BCD8A54C82B48D739A6214156164057AE4318E38A2864F4E85EC24209CED68B180F08BDDBC680EF56844AC80538AA9E0F9565FF50CBE25580052A3F918A4723111EBCCD95E399E0CF52B15B2A0FD577866A565B2D75AAC2997B02205CC7247434A7423F2AB59B9961A25FEF39D9D95E697D7412FD6FCF9927542502660C122508DD736E92250DFD5F607BC77F07366309A575769021BC6B1CE0D18DE03108B5BD8555CEE445E03A5E13CE33014BB01A4C26C205536F0F5DE70A89932585D2DA3571178A0BF8191808A220B8214A81601A07A4FAB2A81BB44E04612539F42F8C15D7B9249B8FC0D6EA71E61EBE7BE73AE7E10682E22467E19E85185A08A444022D2CF6933D5E3E954491241D80E18A3C85EB546603175A0AC3E616687A291FC3388B9E095E3C68B3E3EDB9E0D12DA7D9EBECF0E18E88352864839B370B9E08DFE060EA550ED8EB968866B857E2E3FF9DD2A2A5FFBEBE4F7EE47E9EAABE98723FA15B54CA8B797FEEE0E3DDBF7072DBFD8BC018E2FEC752723F4C4957FE9F936D4A70C602A793874C1739D7A87274FC304657478A33F7074B1B6DB8CA70AE706515A217D9D4AB4960C73556734542F4E35CB82C544F97FA1C36AA25D0B14CE7B12E736F3059D77817A09AF6ABB4DBE0DD92BB099CA53E0B36D5A1015A13B3015FB848EDDEF21F33A3F499B264B1E0CE1B025D18AF069DF365E6A9A61C2D1E5A9AACEABCBCACF52A5A34AFA3479B5E9238C678ACF56CF989B3C81AB6F99BC5F84626CA7078BE6CE9674A6E4B4A983AC91A8C5B248D9C9E8742AA53A2C892E814310F22EB99E9A01DFE5350ABFBA06DA7C2AD8AD7FAFFF5386874AE99C71A482A159EA35411A6FF544030EC6C83A5FD32A144B494A139A749C4BA4A591F74DEEDD411E447C371A4AD4B1D437A60C34F3D437253BF9EA560C3D54D6B0DB2651A745F6A4A9D40C65BB215EAEB1832EB10EAF0D9C9700C55B5AF63A94E8763CACA791D4B76F2FA2ED1CC8D965F14A97EA7ED8B872D066E8B569DD1ED9EBC59176C5D0CF20A8DA7CD33B4264A9A63D8C90BCD33D9D13846F263562CDB7056E1329F946E531630A3504DF3A2B17BE3605591EC89EB20EF4F61A02BC8628B9E104DF483C9E20F3AA7213A6AF5E092B07005526513888B33FFA1B1B3F8EFEC0F3C29033A6089F0EA2354A835BA73481A39BF344679F64484FF48843DBE3C7F521740E80EF85153F2B7A1F6FAB0FA625A3767D12188C78E9E2F6CCEE74652678AB79F76A4DFDD2E50D0A8B98135B85DB0003633F7730A72E45CFCFA9041ED39D702F3DE91B3EFFC393E260B8EC751CEC146907EC67CDE5A9A9BD3D9AEC9FCC06A05AED9295050E01CFB59D69F13E993C056942E983D94B3F1B7497DC038AFF7F1B002A1639950ACA85209ACA956A3752342E68731A13559ED9E6048FED1A294D8CC9B538881E9C4620836845477EB53623534BA4BF2CE5D479F93B4354C355359766A33D237E326838DF78A7ED2D393BEB8A3B42FC5ECD5C4EE9557E7C62B6B48676EB0E468D82CDFB5AF825A96615DBBB036A46DDBA9369C1DDC96371DB8DB79EEDFC2954BB49E655CC74065E66D632CDFB185ABCBD898F486AFDF760B57ECF8FA846B1FCFAC7C63AE8FBEBE7823B68BF630861157FB488CD12EC37585427F3266E03762AD7C73C156BC887983A3E289D1725C82220106E2B150E18AF80AAF71AC97E9A78C4F8426F8E42C5A4270C1AE1315270A458668491B1F6574EAE8A39FAE509B3C4FAFE3F4FBC34B88806C8628025CB39324A441C9F7794BDFD38142E7A4BCC9D7B654BAD95F6F4B4C579C0D4494ABAF4CA57710C51491C96BB6204FF01CDEEE257C8435F1B7C54CDD8D64B7219A6A9F9E86642D4824731C153CFE441F0EA2CDFB7F01FCFA2E002B210000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201807280055121_SeedData'
BEGIN
    
                    SET IDENTITY_INSERT [dbo].[Pubs] ON
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(1, 'Emmets Irish Pub and Resturant', 'Boston, MA', 4.4);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(2, 'Solas Irish Pub', 'Boston, MA', 4.1);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(3, 'Lansdowne Pub', 'Boston, MA', 4.1);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(4, 'McGanns Irish Pub', 'Boston, MA', 4.1);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(5, 'Ts Pub Boston', 'Boston, MA', 3.9);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(6, 'The Black Rose', 'Boston, MA', 4.4);
                    INSERT INTO [dbo].[Pubs]([Id], [Name], [Location], [Rate]) VALUES(7, 'Eire Pub', 'Boston, MA', 4.5);
                    SET IDENTITY_INSERT [dbo].[Pubs] OFF
                    
                    SET IDENTITY_INSERT [dbo].[Beers] ON
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(1, 'Bud Light', 4.2);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(2, 'Corona', 4.6);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(3, 'Ballast Point', 7.0);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(4, 'Guinness', 4.27);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(5, 'Coors Light', 4.2);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(6, 'Greens Tripel Blonde Ale', 8.5);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(7, 'Natural Ice', 5.9);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(8, 'King Cobra', 6.0);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(9, 'Molson Canadian 67', 3.0);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(10, 'Sleeman Clear', 4.0);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(11, 'Michelob Ultra', 4.2);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(12, 'Natural Light', 4.2);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(13, 'Natty Daddy', 8.2);
                    INSERT INTO [dbo].[Beers]([Id], [Brand], [Abv]) VALUES(14, 'Bud Select 55', 2.4);
                    SET IDENTITY_INSERT [dbo].[Beers] OFF
    
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (6, 7);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (1, 5);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (3, 3);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (7, 11);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (6, 8);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (4, 9);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (1, 3);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (5, 4);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (1, 14);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (5, 1);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (3, 7);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (7, 10);
                    INSERT INTO [dbo].[PubBeers] ([Pub_Id], [Beer_Id]) VALUES (2, 3);
                
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201807280055121_SeedData', N'Zoolab.Migrations.Configuration',  0x1F8B0800000000000400ED19DB6ADC46F4BDD07F107A2CCECA7608B46637C15EDBC534BEE0B543E98B9995CEAE454733EACCC8EC12FA657DE827F5177A4677CD485AC9714C092560B23373EEF7A37FFEFA7BFA611351E709840C399BB907937DD701E6F32064EB999BA8D59B1FDD0FEFBFFF6E7A16441BE753F1EEAD7E87904CCEDC47A5E223CF93FE2344444EA2D0175CF2959AF83CF248C0BDC3FDFD9FBC83030F10858BB81C677A9B30154690FEC09F73CE7C885542E8250F80CAFC1C6F162956E78A442063E2C3CCFD8D734A96931BCD8A54C82B48D739A6214156164057AE4318E38A2864F4E85EC24209CED68B180F08BDDBC680EF56844AC80538AA9E0F9565FF50CBE25580052A3F918A4723111EBCCD95E399E0CF52B15B2A0FD577866A565B2D75AAC2997B02205CC7247434A7423F2AB59B9961A25FEF39D9D95E697D7412FD6FCF9927542502660C122508DD736E92250DFD5F607BC77F07366309A575769021BC6B1CE0D18DE03108B5BD8555CEE445E03A5E13CE33014BB01A4C26C205536F0F5DE70A89932585D2DA3571178A0BF8191808A220B8214A81601A07A4FAB2A81BB44E04612539F42F8C15D7B9249B8FC0D6EA71E61EBE7BE73AE7E10682E22467E19E85185A08A444022D2CF6933D5E3E954491241D80E18A3C85EB546603175A0AC3E616687A291FC3388B9E095E3C68B3E3EDB9E0D12DA7D9EBECF0E18E88352864839B370B9E08DFE060EA550ED8EB968866B857E2E3FF9DD2A2A5FFBEBE4F7EE47E9EAABE98723FA15B54CA8B797FEEE0E3DDBF7072DBFD8BC018E2FEC752723F4C4957FE9F936D4A70C602A793874C1739D7A87274FC304657478A33F7074B1B6DB8CA70AE706515A217D9D4AB4960C73556734542F4E35CB82C544F97FA1C36AA25D0B14CE7B12E736F3059D77817A09AF6ABB4DBE0DD92BB099CA53E0B36D5A1015A13B3015FB848EDDEF21F33A3F499B264B1E0CE1B025D18AF069DF365E6A9A61C2D1E5A9AACEABCBCACF52A5A34AFA3479B5E9238C678ACF56CF989B3C81AB6F99BC5F84626CA7078BE6CE9674A6E4B4A983AC91A8C5B248D9C9E8742AA53A2C892E814310F22EB99E9A01DFE5350ABFBA06DA7C2AD8AD7FAFFF5386874AE99C71A482A159EA35411A6FF544030EC6C83A5FD32A144B494A139A749C4BA4A591F74DEEDD411E447C371A4AD4B1D437A60C34F3D437253BF9EA560C3D54D6B0DB2651A745F6A4A9D40C65BB215EAEB1832EB10EAF0D9C9700C55B5AF63A94E8763CACA791D4B76F2FA2ED1CC8D965F14A97EA7ED8B872D066E8B569DD1ED9EBC59176C5D0CF20A8DA7CD33B4264A9A63D8C90BCD33D9D13846F263562CDB7056E1329F946E531630A3504DF3A2B17BE3605591EC89EB20EF4F61A02BC8628B9E104DF483C9E20F3AA7213A6AF5E092B07005526513888B33FFA1B1B3F8EFEC0F3C29033A6089F0EA2354A835BA73481A39BF344679F64484FF48843DBE3C7F521740E80EF85153F2B7A1F6FAB0FA625A3767D12188C78E9E2F6CCEE74652678AB79F76A4DFDD2E50D0A8B98135B85DB0003633F7730A72E45CFCFA9041ED39D702F3DE91B3EFFC393E260B8EC751CEC146907EC67CDE5A9A9BD3D9AEC9FCC06A05AED9295050E01CFB59D69F13E993C056942E983D94B3F1B7497DC038AFF7F1B002A1639950ACA85209ACA956A3752342E68731A13559ED9E6048FED1A294D8CC9B538881E9C4620836845477EB53623534BA4BF2CE5D479F93B4354C355359766A33D237E326838DF78A7ED2D393BEB8A3B42FC5ECD5C4EE9557E7C62B6B48676EB0E468D82CDFB5AF825A96615DBBB036A46DDBA9369C1DDC96371DB8DB79EEDFC2954BB49E655CC74065E66D632CDFB185ABCBD898F486AFDF760B57ECF8FA846B1FCFAC7C63AE8FBEBE7823B68BF630861157FB488CD12EC37585427F3266E03762AD7C73C156BC887983A3E289D1725C82220106E2B150E18AF80AAF71AC97E9A78C4F8426F8E42C5A4270C1AE1315270A458668491B1F6574EAE8A39FAE509B3C4FAFE3F4FBC34B88806C8628025CB39324A441C9F7794BDFD38142E7A4BCC9D7B654BAD95F6F4B4C579C0D4494ABAF4CA57710C51491C96BB6204FF01CDEEE257C8435F1B7C54CDD8D64B7219A6A9F9E86642D4824731C153CFE441F0EA2CDFB7F01FCFA2E002B210000 , N'6.2.0-61023')
END

