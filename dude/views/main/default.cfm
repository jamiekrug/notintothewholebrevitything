<h1>Not Into the Whole Brevity Thing?</h1>
<h2>The Dude Abides</h2>
<p>In case you're not a fan, this domain name is of course inspired by a <a href="http://www.imdb.com/title/tt0118715/quotes">quote</a> from the Coen brothers' (<a href="http://www.imdb.com/name/nm0001053/">Ethan</a> and <a href="http://www.imdb.com/name/nm0001054/">Joel</a>) <em><a href="http://www.imdb.com/title/tt0118715/">The Big Lebowski</a></em>.</p>
<p>I purchased the <em>notintothewholebrevitything.com</em> domain name as a complete random impulse buy, because it made me laugh. When I told my wife, she had a great idea for the site, IMO -- a glossary of chat/text/IM abbreviations and acronyms. I'm sure this has been done, but it's fitting and I like the domain name!</p>
<h2>Chat/IM/SMS/Texting Abbreviations &amp; Acronyms</h2>
<dl>
	<cfoutput>
		<cfloop array="#rc.abbreviations#" index="local.abbreviation">
			<dt>#local.abbreviation.getText()#</dt>
			<cfif arrayLen( local.abbreviation.getDefinitions() )>
				<dd>
					<cfloop array="#local.abbreviation.getDefinitions()#" index="local.definition">
						#local.definition.getText()#<br />
					</cfloop>
				</dd>
			</cfif>
		</cfloop>
	</cfoutput>
</dl>
<p><a href="http://im.the.dude.so.thats.what.you.call.me.you.know.that.or.uh.his.dudeness.or.uh.duder.or.el.duderino.if.youre.notintothewholebrevitything.com/">Click here if <em>notintothewholebrevitything.com</em> still carries too much brevity for your taste ;-)</a></p>
