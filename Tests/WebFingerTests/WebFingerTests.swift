import Testing
import WebFinger

import Foundation

struct WebFingerTests {
	@Test
	func resourceDecode() throws {
		let content = """
   {"subject":"acct:mattiem@mastodon.social","aliases":["https://mastodon.social/@mattiem","https://mastodon.social/users/mattiem"],"links":[{"rel":"http://webfinger.net/rel/profile-page","type":"text/html","href":"https://mastodon.social/@mattiem"},{"rel":"self","type":"application/activity+json","href":"https://mastodon.social/users/mattiem"},{"rel":"http://ostatus.org/schema/1.0/subscribe","template":"https://mastodon.social/authorize_interaction?uri={uri}"},{"rel":"http://webfinger.net/rel/avatar","type":"image/jpeg","href":"https://files.mastodon.social/accounts/avatars/000/412/786/original/8411941f90338786.jpeg"}]}
"""

		let resource = try JSONDecoder().decode(WebFingerResource.Descriptor.self, from: Data(content.utf8))

		let expected = WebFingerResource.Descriptor(
			subject: "acct:mattiem@mastodon.social",
			aliases: [
				"https://mastodon.social/@mattiem",
				"https://mastodon.social/users/mattiem"
			],
			links: [
				WebFingerResource.Descriptor.Link(
					rel: "http://webfinger.net/rel/profile-page",
					type: "text/html",
					href: "https://mastodon.social/@mattiem"
				),
				WebFingerResource.Descriptor.Link(
					rel: "self",
					type: "application/activity+json",
					href: "https://mastodon.social/users/mattiem"
				),
				// this "template" property is, as far as I can tell, out of spec
				WebFingerResource.Descriptor.Link(
					rel: "http://ostatus.org/schema/1.0/subscribe",
					type: nil,
					href: nil
				),
				WebFingerResource.Descriptor.Link(
					rel: "http://webfinger.net/rel/avatar",
					type: "image/jpeg",
					href: "https://files.mastodon.social/accounts/avatars/000/412/786/original/8411941f90338786.jpeg"
				),
			]
		)

		#expect(expected == resource)
	}

	@Test
	func resourceEncode() throws {
		let resource = WebFingerResource.Descriptor(
			subject: "acct:mattiem@mastodon.social",
			aliases: [
				"https://mastodon.social/@mattiem",
				"https://mastodon.social/users/mattiem"
			],
			links: [
				WebFingerResource.Descriptor.Link(
					rel: "http://webfinger.net/rel/profile-page",
					type: "text/html",
					href: "https://mastodon.social/@mattiem"
				),
			]
		)

		let data = try JSONEncoder().encode(resource)
		let output = try JSONDecoder().decode(WebFingerResource.Descriptor.self, from: data)

		#expect(output == resource)
	}

	@Test
	func decodeQueryString() async throws {
		let query = WebFingerResource.Query(
			resource: "acct:Gargron@mastodon.social",
			rel: ["http://webfinger.net/rel/profile-page"]
		)

		#expect(query?.user == "Gargron")
		#expect(query?.server == "mastodon.social")
		#expect(query?.rel == ["http://webfinger.net/rel/profile-page"])
	}
}
