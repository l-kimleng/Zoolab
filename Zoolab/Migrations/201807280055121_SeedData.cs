namespace Zoolab.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class SeedData : DbMigration
    {
        public override void Up()
        {
            Sql(@"
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
            ");
        }
        
        public override void Down()
        {
            Sql(@"
                DELETE FROM [dbo].[Pubs] WHERE [Id] BETWEEN 1 AND 7;
                DELETE FROM [dbo].[Beers] WHERE [Id] BETWEEN 1 AND 14;
            ");
        }
    }
}
