package main

import (
	"fmt"
	"log"

	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		fmt.Printf("Headers : %+v", c.GetReqHeaders())
		return c.SendString(`OK`)
	})

	log.Fatal(app.Listen(":3000"))
}