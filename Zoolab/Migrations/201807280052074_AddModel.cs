namespace Zoolab.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddModel : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Beers",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Brand = c.String(nullable: false, maxLength: 255),
                        Abv = c.Single(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Pubs",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 255),
                        Location = c.String(maxLength: 255),
                        Rate = c.Single(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.PubBeers",
                c => new
                    {
                        Pub_Id = c.Int(nullable: false),
                        Beer_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Pub_Id, t.Beer_Id })
                .ForeignKey("dbo.Pubs", t => t.Pub_Id, cascadeDelete: true)
                .ForeignKey("dbo.Beers", t => t.Beer_Id, cascadeDelete: true)
                .Index(t => t.Pub_Id)
                .Index(t => t.Beer_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.PubBeers", "Beer_Id", "dbo.Beers");
            DropForeignKey("dbo.PubBeers", "Pub_Id", "dbo.Pubs");
            DropIndex("dbo.PubBeers", new[] { "Beer_Id" });
            DropIndex("dbo.PubBeers", new[] { "Pub_Id" });
            DropTable("dbo.PubBeers");
            DropTable("dbo.Pubs");
            DropTable("dbo.Beers");
        }
    }
}
